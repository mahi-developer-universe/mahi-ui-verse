$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$RegistryJsonPath = Join-Path $Root "registry\resources.json"
$RegistryCsvPath = Join-Path $Root "registry\resources.csv"

if (-not (Test-Path $RegistryJsonPath)) {
    Write-Error "Canonical registry file not found: $RegistryJsonPath"
    exit 1
}

$Raw = Get-Content -LiteralPath $RegistryJsonPath -Raw -Encoding UTF8
$Resources = ConvertFrom-Json $Raw

$Resources |
    Export-Csv $RegistryCsvPath `
    -NoTypeInformation `
    -Encoding UTF8

Write-Host ""
Write-Host "CANONICAL REGISTRY SYNC" -ForegroundColor Cyan
Write-Host "Resources in canonical JSON : $($Resources.Count)" -ForegroundColor Green
Write-Host "Exported to CSV             : $RegistryCsvPath" -ForegroundColor Green
Write-Host ""
