$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot

$Files = Get-ChildItem $Root -Recurse -Filter "*.md" |
    Where-Object {
        $_.FullName -notmatch "\\reports\\" -and
        $_.FullName -notmatch "\\.git\\"
    }

$Records = @()

foreach ($File in $Files) {

    $Content = Get-Content $File.FullName -Raw

    $Matches = [regex]::Matches(
        $Content,
        'https?://[^\s\)\]\>"'']+'
    )

    foreach ($Match in $Matches) {

        $Url = $Match.Value.TrimEnd(
            '.',
            ',',
            ';',
            ':',
            ')',
            ']',
            '"',
            "'"
        )

        try {

            $Uri = [System.Uri]$Url
            $Builder = [System.UriBuilder]$Uri

            if ($Builder.Query) {

                $Parameters = $Builder.Query.TrimStart('?').Split('&') |
                    Where-Object {
                        $_ -notmatch '^utm_source=' -and
                        $_ -notmatch '^utm_medium=' -and
                        $_ -notmatch '^utm_campaign=' -and
                        $_ -notmatch '^utm_term=' -and
                        $_ -notmatch '^utm_content=' -and
                        $_ -notmatch '^fbclid=' -and
                        $_ -notmatch '^gclid='
                    }

                $Builder.Query = ($Parameters -join '&')
            }

            $Canonical = $Builder.Uri.AbsoluteUri.TrimEnd('/')
        }
        catch {

            $Canonical = $Url
        }

        $Records += [PSCustomObject]@{
            File = $File.FullName.Replace($Root, "").TrimStart('\')
            Url = $Url
            CanonicalUrl = $Canonical
        }
    }
}

$Groups = $Records |
    Group-Object CanonicalUrl |
    Where-Object Count -gt 1 |
    Sort-Object Count -Descending

$Rows = @()

foreach ($Group in $Groups) {

    foreach ($Item in $Group.Group) {

        $Rows += [PSCustomObject]@{
            CanonicalUrl = $Group.Name
            File = $Item.File
            Url = $Item.Url
        }
    }
}

New-Item -ItemType Directory -Force "$Root\reports\duplicates" | Out-Null

$Rows |
    Export-Csv "$Root\reports\duplicates\duplicate-urls.csv" `
    -NoTypeInformation `
    -Encoding UTF8

$Report = @(
    "# Duplicate URL Audit"
    ""
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ""
    "- URL occurrences: $($Records.Count)"
    "- Duplicate groups: $($Groups.Count)"
    ""
)

foreach ($Group in $Groups) {

    $Report += "## $($Group.Name)"
    $Report += ""

    foreach ($Item in $Group.Group) {
        $Report += "- ``$($Item.File)`` → $($Item.Url)"
    }

    $Report += ""
}

$Report -join "`n" |
    Set-Content "$Root\reports\duplicates\duplicate-urls.md" -Encoding UTF8

Write-Host ""
Write-Host "DUPLICATE URL AUDIT" -ForegroundColor Cyan
Write-Host "URLs scanned   : $($Records.Count)"
Write-Host "Duplicate groups: $($Groups.Count)" -ForegroundColor Yellow
Write-Host ""
