$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot

$Files = Get-ChildItem "$Root\resources" -Recurse -Filter "*.md"

$Names = @()

foreach ($File in $Files) {

    foreach ($Line in Get-Content $File.FullName) {

        if ($Line -match '^\s*\d+\.\s+\*\*(.+?)\*\*') {

            $Name = $Matches[1].Trim()

            $Normalized = $Name.ToLowerInvariant()

            $Normalized = $Normalized -replace '[^a-z0-9]+', ' '

            $Normalized = $Normalized.Trim()

            $Names += [PSCustomObject]@{
                Name = $Name
                Normalized = $Normalized
                File = $File.FullName.Replace($Root, "").TrimStart('\')
            }
        }
    }
}

$Groups = $Names |
    Group-Object Normalized |
    Where-Object Count -gt 1

$Rows = @()

foreach ($Group in $Groups) {

    foreach ($Item in $Group.Group) {

        $Rows += [PSCustomObject]@{
            Normalized = $Group.Name
            Name = $Item.Name
            File = $Item.File
        }
    }
}

New-Item -ItemType Directory -Force "$Root\reports\duplicates" | Out-Null

$Rows |
    Export-Csv "$Root\reports\duplicates\near-duplicate-names.csv" `
    -NoTypeInformation `
    -Encoding UTF8

$Report = @(
    "# Near Duplicate Name Audit"
    ""
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ""
    "Groups: $($Groups.Count)"
    ""
)

foreach ($Group in $Groups) {

    $Report += "## $($Group.Name)"
    $Report += ""

    foreach ($Item in $Group.Group) {
        $Report += "- $($Item.Name) — ``$($Item.File)``"
    }

    $Report += ""
}

$Report -join "`n" |
    Set-Content "$Root\reports\duplicates\near-duplicate-names.md" -Encoding UTF8

Write-Host ""
Write-Host "NEAR DUPLICATE AUDIT" -ForegroundColor Cyan
Write-Host "Near duplicate groups: $($Groups.Count)" -ForegroundColor Yellow
Write-Host ""
