$ErrorActionPreference = "Stop"
$Root = (Resolve-Path ".").Path
$OutDir = Join-Path $Root "reports"
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

$Excluded = '\\(\.git|node_modules|backups|reports|dist|coverage)\\'
$Files = @(Get-ChildItem $Root -Recurse -File -Filter "*.md" |
    Where-Object { $_.FullName -notmatch $Excluded })

$Rows = foreach ($File in $Files) {
    $LineNo = 0
    foreach ($Line in Get-Content -LiteralPath $File.FullName) {
        $LineNo++
        foreach ($Match in [regex]::Matches($Line, 'https?://[^\s\)\]\>\|"''`]+')) {
            $Raw = $Match.Value.TrimEnd('.', ',', ';', ':')
            try {
                $Uri = [uri]$Raw
                $HostName = $Uri.Host.ToLowerInvariant() -replace '^www\.', ''
                $Path = $Uri.AbsolutePath.TrimEnd('/').ToLowerInvariant()
                if (-not $Path) { $Path = '/' }
                $Query = $Uri.Query
                $Canonical = "$HostName$Path$Query"

                [pscustomobject]@{
                    CanonicalURL = $Canonical
                    OriginalURL = $Raw
                    File = $File.FullName.Substring($Root.Length).TrimStart('\')
                    Line = $LineNo
                }
            } catch {
                # Malformed URLs are reported by the validator.
            }
        }
    }
}

$Duplicates = @($Rows | Group-Object CanonicalURL |
    Where-Object { $_.Count -gt 1 })

$Details = foreach ($Group in $Duplicates) {
    foreach ($Item in $Group.Group) {
        [pscustomobject]@{
            CanonicalURL = $Group.Name
            Occurrences = $Group.Count
            File = $Item.File
            Line = $Item.Line
            OriginalURL = $Item.OriginalURL
        }
    }
}

$Csv = Join-Path $OutDir "duplicate-urls.csv"
$Md = Join-Path $OutDir "duplicate-urls.md"

if ($Details) {
    $Details | Export-Csv -LiteralPath $Csv -NoTypeInformation -Encoding utf8
    $Table = $Details | Format-Table -AutoSize | Out-String -Width 240
    @"
# Duplicate URL Audit

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

Markdown files scanned: $($Files.Count)
URL occurrences: $(@($Rows).Count)
Duplicate canonical URL groups: $($Duplicates.Count)

These are review candidates, not automatic deletion instructions.
Repeated URLs can be valid in navigation, examples, and cross-category lists.

````text
$Table
````
"@ | Set-Content -LiteralPath $Md -Encoding utf8
    Write-Host "Potential duplicates: $($Duplicates.Count) groups" -ForegroundColor Yellow
    Write-Host "CSV: $Csv"
    Write-Host "Report: $Md"
} else {
    "No repeated canonical URLs found." |
        Set-Content -LiteralPath $Md -Encoding utf8
    Write-Host "No repeated canonical URLs found." -ForegroundColor Green
}

Write-Host "Markdown files scanned: $($Files.Count)"
