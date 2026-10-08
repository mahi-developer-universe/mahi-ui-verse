param(
    [switch]$Strict
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$RegistryJsonPath = Join-Path $Root "registry\resources.json"
$DirectoryMdPath = Join-Path $Root "resources\website-directory.md"

$Issues = [System.Collections.Generic.List[object]]::new()

if (-not (Test-Path $RegistryJsonPath)) {
    $Issues.Add([PSCustomObject]@{
        Severity = "ERROR"
        Issue = "Missing registry/resources.json file"
    })
}

if (-not (Test-Path $DirectoryMdPath)) {
    $Issues.Add([PSCustomObject]@{
        Severity = "ERROR"
        Issue = "Missing resources/website-directory.md file"
    })
}

$Registry = @()
if (Test-Path $RegistryJsonPath) {
    try {
        $Raw = Get-Content -LiteralPath $RegistryJsonPath -Raw -Encoding UTF8
        $Registry = ConvertFrom-Json $Raw
    }
    catch {
        $Issues.Add([PSCustomObject]@{
            Severity = "ERROR"
            Issue = "Failed to parse registry/resources.json: $($_.Exception.Message)"
        })
    }
}

$DirectoryResources = @()
if (Test-Path $DirectoryMdPath) {
    $Lines = Get-Content -LiteralPath $DirectoryMdPath -Encoding UTF8
    foreach ($Line in $Lines) {
        if ($Line -match '^\s*(\d+)\.\s+(.*?)\s+—\s+\[(.*?)\]\((.*?)\)') {
            $DirectoryResources += [PSCustomObject]@{
                Number = [int]$Matches[1]
                Name = $Matches[2].Trim()
                Url = $Matches[4].Trim()
                CanonicalUrl = ($Matches[4].Trim().ToLowerInvariant() -replace '^https?://', '' -replace '^www\.', '').TrimEnd('/')
            }
        }
    }
}

# 1. Total counts comparison
$RegistryCount = $Registry.Count
$MarkdownCount = $DirectoryResources.Count

# 2. Check for missing entries both ways
$RegistryUrlMap = @{}
$RegistryIdMap = @{}
$RegistryNameMap = @{}

foreach ($Item in $Registry) {
    $CleanUrl = ($Item.website.Trim().ToLowerInvariant() -replace '^https?://', '' -replace '^www\.', '').TrimEnd('/')
    $RegistryUrlMap[$CleanUrl] = $Item
    
    if ($RegistryIdMap.ContainsKey($Item.id)) {
        $Issues.Add([PSCustomObject]@{
            Severity = "ERROR"
            Issue = "Duplicate ID in registry: $($Item.id)"
        })
    } else {
        $RegistryIdMap[$Item.id] = $Item
    }

    if ($RegistryNameMap.ContainsKey($Item.name.ToLowerInvariant())) {
        $Issues.Add([PSCustomObject]@{
            Severity = "WARNING"
            Issue = "Duplicate Name in registry: $($Item.name)"
        })
    } else {
        $RegistryNameMap[$Item.name.ToLowerInvariant()] = $Item
    }
}

$MarkdownUrlMap = @{}
foreach ($Item in $DirectoryResources) {
    $MarkdownUrlMap[$Item.CanonicalUrl] = $Item
}

$MissingFromRegistry = @()
foreach ($Item in $DirectoryResources) {
    if (-not $RegistryUrlMap.ContainsKey($Item.CanonicalUrl)) {
        $MissingFromRegistry += $Item
        $Issues.Add([PSCustomObject]@{
            Severity = "ERROR"
            Issue = "Resource in Markdown missing from Registry: '$($Item.Name)' ($($Item.Url))"
        })
    }
}

$MissingFromMarkdown = @()
foreach ($Item in $Registry) {
    $CleanUrl = ($Item.website.Trim().ToLowerInvariant() -replace '^https?://', '' -replace '^www\.', '').TrimEnd('/')
    if (-not $MarkdownUrlMap.ContainsKey($CleanUrl)) {
        $MissingFromMarkdown += $Item
        $Issues.Add([PSCustomObject]@{
            Severity = "ERROR"
            Issue = "Resource in Registry missing from Markdown: '$($Item.name)' ($($Item.website))"
        })
    }
}

$ErrorCount = @($Issues | Where-Object { $_.Severity -eq "ERROR" }).Count
$WarningCount = @($Issues | Where-Object { $_.Severity -eq "WARNING" }).Count
$Pass = ($ErrorCount -eq 0 -and $RegistryCount -eq $MarkdownCount)

# Generate report
$OutDir = Join-Path $Root "reports"
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
$ReportPath = Join-Path $OutDir "registry-sync.md"

$ReportLines = @(
    "# Markdown ↔ Registry Synchronization Audit"
    ""
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ""
    "| Metric | Count |"
    "|---|---:|"
    "| Registry resources | $RegistryCount |"
    "| Markdown resources | $MarkdownCount |"
    "| Missing from registry | $($MissingFromRegistry.Count) |"
    "| Missing from Markdown | $($MissingFromMarkdown.Count) |"
    "| Duplicate IDs | $(@($Issues | Where-Object { $_.Issue -like '*Duplicate ID*' }).Count) |"
    "| Errors | $ErrorCount |"
    "| Warnings | $WarningCount |"
    "| Status | $(if ($Pass) { '**PASS**' } else { '**FAIL**' }) |"
    ""
)

if ($Issues.Count -gt 0) {
    $ReportLines += "## Discrepancies"
    $ReportLines += ""
    foreach ($Issue in $Issues) {
        $ReportLines += "- **[$($Issue.Severity)]** $($Issue.Issue)"
    }
    $ReportLines += ""
}

$ReportLines -join "`n" | Set-Content -LiteralPath $ReportPath -Encoding UTF8

Write-Host ""
Write-Host "REGISTRY ↔ MARKDOWN SYNCHRONIZATION" -ForegroundColor Cyan
Write-Host "Registry entries: $RegistryCount"
Write-Host "Markdown entries: $MarkdownCount"
Write-Host "Missing from registry: $($MissingFromRegistry.Count)"
Write-Host "Missing from Markdown: $($MissingFromMarkdown.Count)"
Write-Host "Status: $(if ($Pass) { 'PASS' } else { 'FAIL' })" -ForegroundColor $(if ($Pass) { "Green" } else { "Red" })
Write-Host "Report generated: $ReportPath"
Write-Host ""

if ($Strict -and -not $Pass) {
    Write-Error "Registry synchronization check failed."
    exit 1
}
