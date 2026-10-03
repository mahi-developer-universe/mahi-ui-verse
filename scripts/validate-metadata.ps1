$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot

$Files = Get-ChildItem "$Root\resources" -Recurse -Filter "*.md"

$Errors = @()
$Warnings = @()

foreach ($File in $Files) {

    $LineNumber = 0

    foreach ($Line in Get-Content $File.FullName) {

        $LineNumber++

        if ($Line -match '^\s*\d+\.\s+\*\*(.+?)\*\*') {

            $Name = $Matches[1].Trim()

            if ([string]::IsNullOrWhiteSpace($Name)) {

                $Errors += [PSCustomObject]@{
                    File = $File.Name
                    Line = $LineNumber
                    Issue = "Empty resource name"
                }
            }
        }
    }
}

New-Item -ItemType Directory -Force "$Root\reports" | Out-Null

$Report = @(
    "# Metadata Validation"
    ""
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ""
    "- Errors: $($Errors.Count)"
    "- Warnings: $($Warnings.Count)"
    ""
)

if ($Errors.Count -gt 0) {

    $Report += "## Errors"
    $Report += ""

    foreach ($Item in $Errors) {
        $Report += "- ``$($Item.File):$($Item.Line)`` — $($Item.Issue)"
    }
}

$Report -join "`n" |
    Set-Content "$Root\reports\metadata-validation.md" -Encoding UTF8

Write-Host ""
Write-Host "METADATA VALIDATION" -ForegroundColor Cyan
Write-Host "Errors  : $($Errors.Count)"
Write-Host "Warnings: $($Warnings.Count)"
Write-Host ""
