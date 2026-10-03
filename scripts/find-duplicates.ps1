$ErrorActionPreference = "Stop"
$Root = (Get-Location).Path

$Files = Get-ChildItem -Path $Root -Recurse -File -Filter "*.md" |
    Where-Object { $_.FullName -notmatch "\\\.git\\|\\backups\\" }

$Rows = foreach ($File in $Files) {
    $Content = Get-Content -LiteralPath $File.FullName -Raw
    if (-not $Content) { continue }

    foreach ($Match in [regex]::Matches($Content, 'https?://[^\s\)\]\>]+')) {
        $Url = $Match.Value.TrimEnd('.', ',', ';', ':')
        try {
            $Parsed = [uri]$Url
            $Canonical = ($Parsed.GetLeftPart([System.UriPartial]::Path)).TrimEnd('/')
            [pscustomobject]@{
                URL = $Canonical.ToLowerInvariant()
                File = $File.FullName.Replace($Root, ".")
            }
        } catch {}
    }
}

$Duplicates = $Rows | Group-Object URL | Where-Object { $_.Count -gt 1 }

if (-not $Duplicates) {
    Write-Host "No repeated URLs found in Markdown files." -ForegroundColor Green
} else {
    foreach ($Group in $Duplicates) {
        Write-Host "`n$($Group.Name)" -ForegroundColor Yellow
        $Group.Group | Select-Object -ExpandProperty File -Unique
    }
}
