$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot

$Files = Get-ChildItem "$Root\resources" -Recurse -Filter "*.md" |
    Where-Object {
        $_.FullName -notmatch "\\reports\\" -and
        $_.FullName -notmatch "\\.git\\"
    }

$Entries = @()

foreach ($File in $Files) {

    $Lines = Get-Content $File.FullName

    foreach ($Line in $Lines) {

        if ($Line -match '^\s*(\d+)\.\s+\*\*(.+?)\*\*') {

            $Entries += [PSCustomObject]@{
                Name = $Matches[2].Trim()
                File = $File.FullName.Replace($Root, "").TrimStart('\')
            }
        }
    }
}

$Grouped = $Entries |
    Group-Object Name |
    Sort-Object Name

$Duplicates = $Grouped |
    Where-Object Count -gt 1

$Total = $Entries.Count
$Unique = $Grouped.Count
$DuplicateNames = $Duplicates.Count

$Stats = [PSCustomObject]@{
    TotalEntries = $Total
    UniqueNames = $Unique
    DuplicateNames = $DuplicateNames
    Generated = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
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
    "| Total entries | $Total |"
    "| Unique names | $Unique |"
    "| Duplicate names | $DuplicateNames |"
    ""
)

if ($Duplicates.Count -gt 0) {

    $Report += "## Duplicate Names"
    $Report += ""

    foreach ($Duplicate in $Duplicates) {
        $Report += "- **$($Duplicate.Name)** — $($Duplicate.Count) occurrences"

        foreach ($Item in $Duplicate.Group) {
            $Report += "  - $($Item.File)"
        }
    }
}

$Report -join "`n" |
    Set-Content "$Root\reports\resource-stats.md" -Encoding UTF8

Write-Host ""
Write-Host "RESOURCE STATISTICS" -ForegroundColor Cyan
Write-Host "Total entries : $Total"
Write-Host "Unique names  : $Unique" -ForegroundColor Green
Write-Host "Duplicate names: $DuplicateNames" -ForegroundColor Yellow
Write-Host ""
