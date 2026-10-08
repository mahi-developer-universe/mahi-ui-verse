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
        $MatchesOnLine = @()
        foreach ($Match in [regex]::Matches($Line, 'https?://[^\s\)\]\>\|"''`]+')) {
            $Raw = $Match.Value.TrimEnd('.', ',', ';', ':')
            try {
                $Uri = [uri]$Raw
                $HostName = $Uri.Host.ToLowerInvariant() -replace '^www\.', ''
                $Path = $Uri.AbsolutePath.TrimEnd('/').ToLowerInvariant()
                if (-not $Path) { $Path = '/' }
                $Query = $Uri.Query
                $Canonical = "$HostName$Path$Query"

                $MatchesOnLine += [pscustomobject]@{
                    CanonicalURL = $Canonical
                    OriginalURL = $Raw
                    File = $File.FullName.Substring($Root.Length).TrimStart('\')
                    Line = $LineNo
                }
            } catch {
                # Malformed URLs are handled by link validator
            }
        }
        # Deduplicate occurrences on the same line (e.g. [https://url](https://url))
        $MatchesOnLine | Sort-Object CanonicalURL -Unique
    }
}

$Duplicates = @($Rows | Group-Object CanonicalURL |
    Where-Object { $_.Count -gt 1 } |
    Sort-Object Count -Descending)

$Csv = Join-Path $OutDir "duplicate-urls.csv"
$Md = Join-Path $OutDir "duplicate-urls.md"

$ReportLines = [System.Collections.Generic.List[string]]::new()
$ReportLines.Add("# Duplicate URL & Reference Audit")
$ReportLines.Add("")
$ReportLines.Add("Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$ReportLines.Add("")
$ReportLines.Add("- **Markdown files scanned**: $($Files.Count)")
$ReportLines.Add("- **Total URL occurrences**: $(@($Rows).Count)")
$ReportLines.Add("- **Duplicate canonical URL groups**: $($Duplicates.Count)")
$ReportLines.Add("")
$ReportLines.Add("> **Classification Guide**:")
$ReportLines.Add("> - **LEGITIMATE CROSS-REFERENCE**: URL referenced across README, directories, category tables, demos, or videos.")
$ReportLines.Add("> - **INTRA-FILE DUPLICATE**: URL repeated multiple times within the exact same markdown file.")
$ReportLines.Add("")

$IntraFileCount = 0
$CrossFileCount = 0

$CsvRecords = [System.Collections.Generic.List[object]]::new()

foreach ($Group in $Duplicates) {
    $FilesOccurring = @($Group.Group | Select-Object -ExpandProperty File -Unique)
    $IsIntra = $false
    
    # Check if any single file has more than 1 occurrence of this URL
    $FileCounts = $Group.Group | Group-Object File
    $IntraFiles = @($FileCounts | Where-Object { $_.Count -gt 1 })
    
    $Classification = if ($IntraFiles.Count -gt 0) {
        $IntraFileCount++
        "INTRA-FILE DUPLICATE — CANDIDATE FOR CLEANUP"
    } else {
        $CrossFileCount++
        "LEGITIMATE CROSS-REFERENCE — KEEP"
    }

    $ReportLines.Add("### $($Group.Name)")
    $ReportLines.Add("- **Occurrences**: $($Group.Count) | **Files**: $($FilesOccurring.Count)")
    $ReportLines.Add("- **Classification**: ``$Classification``")
    $ReportLines.Add("- **Locations**:")
    foreach ($Item in $Group.Group) {
        $ReportLines.Add("  - ``$($Item.File):$($Item.Line)``")
        $CsvRecords.Add([pscustomobject]@{
            CanonicalURL = $Group.Name
            Occurrences = $Group.Count
            FilesCount = $FilesOccurring.Count
            Classification = $Classification
            File = $Item.File
            Line = $Item.Line
            OriginalURL = $Item.OriginalURL
        })
    }
    $ReportLines.Add("")
}

$CsvRecords | Export-Csv -LiteralPath $Csv -NoTypeInformation -Encoding utf8
$ReportLines -join "`n" | Set-Content -LiteralPath $Md -Encoding utf8

Write-Host ""
Write-Host "DUPLICATE URL AUDIT COMPLETE" -ForegroundColor Cyan
Write-Host "Duplicate canonical groups: $($Duplicates.Count)"
Write-Host "Intra-file duplicate groups: $IntraFileCount" -ForegroundColor $(if ($IntraFileCount -eq 0) { "Green" } else { "Yellow" })
Write-Host "Legitimate cross-references: $CrossFileCount" -ForegroundColor Green
Write-Host "Report generated at: $Md"
Write-Host ""
