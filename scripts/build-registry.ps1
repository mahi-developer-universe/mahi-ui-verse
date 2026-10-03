$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot

$Files = Get-ChildItem "$Root\resources" -Recurse -Filter "*.md" |
    Where-Object {
        $_.FullName -notmatch "\\reports\\" -and
        $_.FullName -notmatch "\\.git\\"
    }

$Resources = @()

foreach ($File in $Files) {

    $Lines = Get-Content $File.FullName

    for ($i = 0; $i -lt $Lines.Count; $i++) {

        $Line = $Lines[$i]

        if ($Line -match '^\s*(\d+)\.\s+\*\*(.+?)\*\*\s*(?:[-–—]\s*)?(https?://\S+)?') {

            $Number = $Matches[1]
            $Name = $Matches[2].Trim()
            $Website = $Matches[3]

            if ($Website) {
                $Website = $Website.TrimEnd('.', ',', ';', ':', ')', ']', '"', "'")
            }

            $Slug = $Name.ToLowerInvariant()
            $Slug = $Slug -replace '[^a-z0-9]+', '-'
            $Slug = $Slug.Trim('-')

            $Id = $Slug

            $Resources += [PSCustomObject]@{
                id = $Id
                name = $Name
                slug = $Slug
                category = "needs-review"
                subcategory = "needs-review"
                type = "needs-review"
                description = ""
                website = $Website
                demo = ""
                documentation = ""
                github = ""
                video = ""
                framework = @()
                technology = @()
                pricing = "unknown"
                license = "unknown"
                openSource = $false
                tags = @()
                status = "needs-review"
                httpStatus = ""
                redirectUrl = ""
                lastVerified = ""
                contributor = "mahi-developer-universe"
                sourceFile = $File.FullName.Replace($Root, "").TrimStart('\')
                sourceNumber = $Number
            }
        }
    }
}

$Resources = $Resources |
    Sort-Object name, website -Unique

$Resources |
    ConvertTo-Json -Depth 10 |
    Set-Content "$Root\registry\resources.json" -Encoding UTF8

$Resources |
    Export-Csv "$Root\registry\resources.csv" `
    -NoTypeInformation `
    -Encoding UTF8

Write-Host ""
Write-Host "CANONICAL REGISTRY" -ForegroundColor Cyan
Write-Host "Resources extracted: $($Resources.Count)" -ForegroundColor Green
Write-Host ""
