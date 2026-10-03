$ErrorActionPreference = "SilentlyContinue"

$Root = Split-Path -Parent $PSScriptRoot

$Files = Get-ChildItem $Root -Recurse -Filter "*.md" |
    Where-Object {
        $_.FullName -notmatch "\\reports\\" -and
        $_.FullName -notmatch "\\.git\\"
    }

$Results = @()

foreach ($File in $Files) {

    $Content = Get-Content $File.FullName -Raw

    $Urls = [regex]::Matches(
        $Content,
        'https?://[^\s\)\]\>"'']+'
    ) |
    ForEach-Object {
        $_.Value.TrimEnd(
            '.',
            ',',
            ';',
            ':',
            ')',
            ']',
            '"',
            "'"
        )
    } |
    Sort-Object -Unique

    foreach ($Url in $Urls) {

        $Status = "ERROR"
        $FinalUrl = ""
        $ErrorMessage = ""

        try {

            $Response = Invoke-WebRequest `
                -Uri $Url `
                -Method Head `
                -MaximumRedirection 10 `
                -TimeoutSec 20 `
                -UseBasicParsing

            $Status = [int]$Response.StatusCode

            if ($Response.BaseResponse.ResponseUri) {
                $FinalUrl = $Response.BaseResponse.ResponseUri.AbsoluteUri
            }
        }
        catch {

            if ($_.Exception.Response) {

                try {
                    $Status = [int]$_.Exception.Response.StatusCode
                }
                catch {
                    $Status = "ERROR"
                }
            }

            $ErrorMessage = $_.Exception.Message
        }

        $Results += [PSCustomObject]@{
            File = $File.FullName.Replace($Root, "").TrimStart('\')
            Url = $Url
            Status = $Status
            FinalUrl = $FinalUrl
            Error = $ErrorMessage
            CheckedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        }

        Write-Host "$Status`t$Url"
    }
}

New-Item -ItemType Directory -Force "$Root\reports\health" | Out-Null

$Results |
    Export-Csv "$Root\reports\health\link-health.csv" `
    -NoTypeInformation `
    -Encoding UTF8

$Summary = $Results |
    Group-Object Status |
    Sort-Object Name

$Report = @(
    "# Link Health Report"
    ""
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ""
    "| Status | Count |"
    "|---|---:|"
)

foreach ($Item in $Summary) {

    $Report += "| $($Item.Name) | $($Item.Count) |"
}

$Report -join "`n" |
    Set-Content "$Root\reports\health\link-health.md" -Encoding UTF8

Write-Host ""
Write-Host "LINK HEALTH COMPLETE" -ForegroundColor Green
Write-Host ""
