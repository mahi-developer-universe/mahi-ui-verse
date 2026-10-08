param(
    [switch]$Strict
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$RegistryJsonPath = Join-Path $Root "registry\resources.json"
$DirectoryMdPath = Join-Path $Root "resources\website-directory.md"

$Errors = [System.Collections.Generic.List[object]]::new()
$Warnings = [System.Collections.Generic.List[object]]::new()

if (-not (Test-Path $RegistryJsonPath)) {
    $Errors.Add([PSCustomObject]@{
        Target = "registry/resources.json"
        Issue = "Missing registry/resources.json file"
    })
}

$Registry = @()
if (Test-Path $RegistryJsonPath) {
    try {
        $Raw = Get-Content -LiteralPath $RegistryJsonPath -Raw -Encoding UTF8
        $Registry = ConvertFrom-Json $Raw
    }
    catch {
        $Errors.Add([PSCustomObject]@{
            Target = "registry/resources.json"
            Issue = "Failed to parse JSON: $($_.Exception.Message)"
        })
    }
}

# Allowed Enums per SCHEMA.md
$AllowedCategories = @("ui", "ux", "frontend", "resources", "inspiration", "learning", "tools", "guides")
$AllowedStatuses = @("active", "needs-review", "redirected", "broken", "archived", "deprecated", "unknown")
$AllowedPricing = @("free", "freemium", "paid", "open-source", "commercial", "unknown")

$SeenIds = @{}
$SeenUrls = @{}

foreach ($Item in $Registry) {
    $Id = $Item.id
    $Name = $Item.name
    $Slug = $Item.slug
    $Website = $Item.website
    $Cat = $Item.category
    $Status = $Item.status
    $Pricing = $Item.pricing

    # Required fields
    if ([string]::IsNullOrWhiteSpace($Id)) {
        $Errors.Add([PSCustomObject]@{ Target = "Registry Item"; Issue = "Missing 'id' field in record: $Name" })
    }
    if ([string]::IsNullOrWhiteSpace($Name)) {
        $Errors.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Missing 'name' field" })
    }
    if ([string]::IsNullOrWhiteSpace($Slug)) {
        $Errors.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Missing 'slug' field" })
    }
    if ([string]::IsNullOrWhiteSpace($Website)) {
        $Errors.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Missing 'website' field" })
    }

    # Format validations
    if ($Slug -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
        $Warnings.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Slug '$Slug' does not follow lowercase kebab-case format" })
    }
    if ($Website -and $Website -notmatch '^https?://') {
        $Errors.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Website URL must begin with http:// or https://" })
    }

    # Allowed enum checks
    if ($Cat -and ($AllowedCategories -notcontains $Cat.ToLowerInvariant()) -and ($Cat -ne "needs-review")) {
        $Warnings.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Category '$Cat' not in standard allowed categories list" })
    }
    if ($Status -and ($AllowedStatuses -notcontains $Status.ToLowerInvariant())) {
        $Warnings.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Status '$Status' not in allowed status values" })
    }
    if ($Pricing -and ($AllowedPricing -notcontains $Pricing.ToLowerInvariant())) {
        $Warnings.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Pricing '$Pricing' not in allowed pricing values" })
    }

    # Uniqueness checks
    if ($Id) {
        if ($SeenIds.ContainsKey($Id)) {
            $Errors.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Duplicate ID '$Id' found (already seen on $($SeenIds[$Id]))" })
        } else {
            $SeenIds[$Id] = $Name
        }
    }

    if ($Website) {
        $CleanUrl = $Website.Trim().ToLowerInvariant().TrimEnd('/')
        if ($SeenUrls.ContainsKey($CleanUrl)) {
            $Warnings.Add([PSCustomObject]@{ Target = "Registry Item $Id"; Issue = "Canonical URL '$CleanUrl' also registered under '$($SeenUrls[$CleanUrl])'" })
        } else {
            $SeenUrls[$CleanUrl] = $Name
        }
    }
}

# Synchronisation check against resources/website-directory.md
if (Test-Path $DirectoryMdPath) {
    $DirLines = Get-Content -LiteralPath $DirectoryMdPath -Encoding UTF8
    $DirEntries = @()
    foreach ($Line in $DirLines) {
        if ($Line -match '^\s*(\d+)\.\s+(.*?)\s+—\s+\[(.*?)\]\((.*?)\)') {
            $DirEntries += [PSCustomObject]@{
                Number = $Matches[1]
                Name = $Matches[2].Trim()
                Url = $Matches[4].Trim()
            }
        }
    }

    if ($Registry.Count -ne $DirEntries.Count) {
        $Errors.Add([PSCustomObject]@{
            Target = "Sync Audit"
            Issue = "Mismatch between Registry ($($Registry.Count) entries) and website-directory.md ($($DirEntries.Count) entries)"
        })
    }
}

New-Item -ItemType Directory -Force "$Root\reports" | Out-Null

$Report = @(
    "# Metadata & Registry Validation"
    ""
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ""
    "| Metric | Count |"
    "|---|---:|"
    "| Registry Entries | $($Registry.Count) |"
    "| Errors | $($Errors.Count) |"
    "| Warnings | $($Warnings.Count) |"
    ""
)

if ($Errors.Count -gt 0) {
    $Report += "## Errors"
    $Report += ""
    foreach ($Item in $Errors) {
        $Report += "- **$($Item.Target)**: $($Item.Issue)"
    }
    $Report += ""
}

if ($Warnings.Count -gt 0) {
    $Report += "## Warnings"
    $Report += ""
    foreach ($Item in $Warnings) {
        $Report += "- **$($Item.Target)**: $($Item.Issue)"
    }
    $Report += ""
}

$Report -join "`n" |
    Set-Content "$Root\reports\metadata-validation.md" -Encoding UTF8

Write-Host ""
Write-Host "METADATA & REGISTRY VALIDATION" -ForegroundColor Cyan
Write-Host "Total Registry Entries: $($Registry.Count)" -ForegroundColor Green
Write-Host "Errors   : $($Errors.Count)" -ForegroundColor $(if ($Errors.Count -eq 0) { "Green" } else { "Red" })
Write-Host "Warnings : $($Warnings.Count)" -ForegroundColor $(if ($Warnings.Count -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

if ($Strict -and $Errors.Count -gt 0) {
    Write-Error "Metadata validation failed with $($Errors.Count) errors."
    exit 1
}
