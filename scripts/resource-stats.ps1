$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$RegistryJsonPath = Join-Path $Root "registry\resources.json"

$Registry = @()
if (Test-Path $RegistryJsonPath) {
    $Raw = Get-Content -LiteralPath $RegistryJsonPath -Raw -Encoding UTF8
    $Registry = ConvertFrom-Json $Raw
}

$Total = $Registry.Count
$Categories = ($Registry | Group-Object category).Count
$Subcategories = ($Registry | Group-Object subcategory).Count
$Free = @($Registry | Where-Object { $_.pricing -eq "free" }).Count
$Paid = @($Registry | Where-Object { $_.pricing -eq "paid" -or $_.pricing -eq "freemium" -or $_.pricing -eq "commercial" }).Count
$OpenSource = @($Registry | Where-Object { $_.openSource -eq $true }).Count
$WithGithub = @($Registry | Where-Object { $_.PSObject.Properties['github'] -and -not [string]::IsNullOrWhiteSpace($_.github) }).Count
$WithDemo = @($Registry | Where-Object { $_.PSObject.Properties['demo'] -and -not [string]::IsNullOrWhiteSpace($_.demo) }).Count
$WithVideo = @($Registry | Where-Object { $_.PSObject.Properties['video'] -and -not [string]::IsNullOrWhiteSpace($_.video) }).Count
$Active = @($Registry | Where-Object { $_.status -eq "active" }).Count

# Check for duplicate IDs or Names in registry
$GroupedNames = $Registry | Group-Object name
$DuplicateNames = ($GroupedNames | Where-Object Count -gt 1).Count

$Stats = [PSCustomObject]@{
    TotalResources    = $Total
    Categories        = $Categories
    Subcategories     = $Subcategories
    OpenSource        = $OpenSource
    Free              = $Free
    Paid              = $Paid
    WithGithub        = $WithGithub
    WithDemo          = $WithDemo
    WithVideo         = $WithVideo
    Active            = $Active
    DuplicateNames    = $DuplicateNames
    Generated         = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
}

New-Item -ItemType Directory -Force "$Root\reports" | Out-Null

$Stats |
    ConvertTo-Json |
    Set-Content "$Root\reports\resource-stats.json" -Encoding UTF8

$Report = @(
    "# Resource Statistics"
    ""
    "Generated: $($Stats.Generated)"
    ""
    "| Metric | Count |"
    "|---|---:|"
    "| Total Resources | $Total |"
    "| Categories | $Categories |"
    "| Subcategories | $Subcategories |"
    "| Open Source Resources | $OpenSource |"
    "| Free Resources | $Free |"
    "| Commercial / Freemium / Paid | $Paid |"
    "| Resources with GitHub Repositories | $WithGithub |"
    "| Resources with Interactive Demos | $WithDemo |"
    "| Resources with Video Links | $WithVideo |"
    "| Active Status Resources | $Active |"
    "| Duplicate Names | $DuplicateNames |"
    ""
)

$Report -join "`n" |
    Set-Content "$Root\reports\resource-stats.md" -Encoding UTF8

Write-Host ""
Write-Host "CANONICAL RESOURCE STATISTICS" -ForegroundColor Cyan
Write-Host "Total Resources : $Total" -ForegroundColor Green
Write-Host "Categories      : $Categories"
Write-Host "Open Source     : $OpenSource"
Write-Host "Free            : $Free"
Write-Host "Paid/Freemium   : $Paid"
Write-Host "With GitHub     : $WithGithub"
Write-Host "With Demo       : $WithDemo"
Write-Host "Duplicate names : $DuplicateNames" -ForegroundColor $(if ($DuplicateNames -eq 0) { "Green" } else { "Yellow" })
Write-Host ""
