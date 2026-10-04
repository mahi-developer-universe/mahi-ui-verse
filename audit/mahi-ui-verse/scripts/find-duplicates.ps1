param(
    [string]$Root = "",
    [string]$OutputDirectory = ""
)

$ErrorActionPreference = "Stop"

if (-not $Root) {
    $Root = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")).Path
}

$Root = (Resolve-Path $Root).Path

if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $PSScriptRoot "..\reports"
}

New-Item -ItemType Directory -Path $OutputDirectory -Force |
    Out-Null

function Get-NormalizedResourceUrl {
    param([string]$Url)

    $Url = $Url.Trim().Trim("<", ">")

    if ($Url -notmatch '^https?://') {
        return $null
    }

    try {
        $Uri = [System.Uri]$Url
        $Builder = [System.UriBuilder]$Uri

        $Builder.Scheme = $Builder.Scheme.ToLowerInvariant()
        $Builder.Host = $Builder.Host.ToLowerInvariant()
        $Builder.Fragment = ""

        $QueryItems = @()

        if ($Builder.Query.TrimStart("?")) {
            foreach ($Item in $Builder.Query.TrimStart("?").Split("&")) {
                if (-not $Item) { continue }

                $Key = ($Item -split "=", 2)[0]

                if ($Key -match '^(?i:utm_.+|fbclid|gclid|twclid|mc_cid|mc_eid)$') {
                    continue
                }

                $QueryItems += $Item
            }
        }

        $Builder.Query = $QueryItems -join "&"

        $Normalized = $Builder.Uri.AbsoluteUri

        if ($Normalized -match '^https?://[^/]+/$') {
            $Normalized = $Normalized.TrimEnd("/")
        }
        elseif ($Normalized -match '\?$') {
            $Normalized = $Normalized.TrimEnd("?")
        }

        return $Normalized
    }
    catch {
        return $null
    }
}

$Excluded = '[\\/](\.git|node_modules|backups|reports|dist|coverage)[\\/]'

$Files = @(
    Get-ChildItem -LiteralPath $Root -Recurse -File -Filter "*.md" |
        Where-Object {
            $_.FullName -notmatch $Excluded -and
            $_.FullName -notmatch '[\\/]audit[\\/]mahi-ui-verse[\\/]'
        }
)

$Records = [System.Collections.Generic.List[object]]::new()

foreach ($File in $Files) {
    $Lines = @(Get-Content -LiteralPath $File.FullName)
    $Relative = $File.FullName.Substring($Root.Length).TrimStart('\','/')

    for ($Index = 0; $Index -lt $Lines.Count; $Index++) {
        $Line = $Lines[$Index]

        $Matches = [regex]::Matches(
            $Line,
            '\[[^\]]*\]\((https?://[^)\s]+)(?:\s+"[^"]*")?\)|(?<!\()https?://[^\s<>"\]\)]+'
        )

        foreach ($Match in $Matches) {
            $RawUrl = $Match.Value

            if ($Match.Groups.Count -gt 1 -and $Match.Groups[1].Success) {
                $RawUrl = $Match.Groups[1].Value
            }

            $RawUrl = $RawUrl.TrimEnd('.', ',', ';', ':')
            $Canonical = Get-NormalizedResourceUrl $RawUrl

            if (-not $Canonical) { continue }

            $Records.Add([pscustomobject]@{
                CanonicalUrl = $Canonical
                OriginalUrl = $RawUrl
                File = $Relative
                Line = $Index + 1
                Text = $Line.Trim()
            })
        }
    }
}

$DuplicateGroups = @(
    $Records |
        Group-Object CanonicalUrl |
        Where-Object { $_.Count -gt 1 } |
        Sort-Object Count -Descending
)

$CsvPath = Join-Path $OutputDirectory "duplicate-scan.csv"
$MdPath = Join-Path $OutputDirectory "duplicate-scan.md"

$Rows = foreach ($Group in $DuplicateGroups) {
    foreach ($Entry in $Group.Group) {
        [pscustomobject]@{
            CanonicalUrl = $Group.Name
            Occurrences = $Group.Count
            File = $Entry.File
            Line = $Entry.Line
            OriginalUrl = $Entry.OriginalUrl
            Entry = $Entry.Text
        }
    }
}

if ($Rows) {
    $Rows | Export-Csv -LiteralPath $CsvPath -NoTypeInformation -Encoding UTF8
}
else {
    @() | Export-Csv -LiteralPath $CsvPath -NoTypeInformation -Encoding UTF8
}

$Markdown = [System.Collections.Generic.List[string]]::new()
$Markdown.Add("# Duplicate URL Scan")
$Markdown.Add("")
$Markdown.Add("Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$Markdown.Add("Files scanned: $($Files.Count)")
$Markdown.Add("URL occurrences: $($Records.Count)")
$Markdown.Add("Duplicate groups: $($DuplicateGroups.Count)")
$Markdown.Add("")
$Markdown.Add("> Review each group before deleting entries. Repeated URLs can be legitimate cross-category references.")
$Markdown.Add("")

foreach ($Group in $DuplicateGroups) {
    $Markdown.Add("## $($Group.Name) ($($Group.Count) occurrences)")
    $Markdown.Add("")

    foreach ($Entry in $Group.Group) {
        $Markdown.Add("- ``$($Entry.File):$($Entry.Line)`` — $($Entry.OriginalUrl)")
    }

    $Markdown.Add("")
}

if ($DuplicateGroups.Count -eq 0) {
    $Markdown.Add("No duplicate URLs detected by this scanner.")
    $Markdown.Add("")
}

$Markdown.Add("## Limitations")
$Markdown.Add("")
$Markdown.Add("- URL normalization is heuristic.")
$Markdown.Add("- This scan does not prove external URLs are reachable.")
$Markdown.Add("- Different paths may represent different resources.")
$Markdown.Add("- Cross-category repetitions require human review.")

Set-Content -LiteralPath $MdPath -Value $Markdown -Encoding UTF8

Write-Host ""
Write-Host "Markdown files scanned: $($Files.Count)"
Write-Host "URL occurrences: $($Records.Count)"
Write-Host "Duplicate groups: $($DuplicateGroups.Count)"
Write-Host "Markdown report: $MdPath"
Write-Host "CSV report: $CsvPath"

if ($DuplicateGroups.Count -gt 0) {
    Write-Host "Review the report before removing any entries." -ForegroundColor Yellow
}
