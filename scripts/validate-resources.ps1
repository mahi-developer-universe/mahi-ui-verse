$ErrorActionPreference = "Stop"
$Root = (Get-Location).Path

Write-Host "`n=== Empty Markdown files ===" -ForegroundColor Cyan
$MarkdownFiles = Get-ChildItem -Path $Root -Recurse -File -Filter "*.md" |
    Where-Object { $_.FullName -notmatch "\\\.git\\|\\backups\\" }

$EmptyFiles = @($MarkdownFiles | Where-Object { $_.Length -eq 0 })
if ($EmptyFiles.Count -eq 0) {
    Write-Host "No empty Markdown files found." -ForegroundColor Green
} else {
    $EmptyFiles | ForEach-Object { Write-Host $_.FullName -ForegroundColor Yellow }
}

Write-Host "`n=== Broken relative Markdown links ===" -ForegroundColor Cyan
$BrokenLinks = 0

foreach ($File in $MarkdownFiles) {
    $Content = Get-Content -LiteralPath $File.FullName -Raw
    if (-not $Content) { continue }

    $Matches = [regex]::Matches($Content, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($Match in $Matches) {
        $Target = $Match.Groups[1].Value.Trim()

        if ($Target -match '^(https?://|mailto:|#)') { continue }
        $Target = ($Target -split '#')[0]
        if (-not $Target) { continue }

        $Resolved = Join-Path $File.DirectoryName $Target
        if (-not (Test-Path -LiteralPath $Resolved)) {
            Write-Host "$($File.FullName): missing link -> $Target" -ForegroundColor Red
            $BrokenLinks++
        }
    }
}

if ($BrokenLinks -eq 0) {
    Write-Host "No broken relative Markdown links found." -ForegroundColor Green
} else {
    Write-Host "Broken relative links found: $BrokenLinks" -ForegroundColor Red
}

Write-Host "`n=== Resource files scanned: $($MarkdownFiles.Count) ==="
