param([switch]$Strict)

$ErrorActionPreference = "Stop"
$Root = (Resolve-Path ".").Path
$OutDir = Join-Path $Root "reports"
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

$Excluded = '\\(\.git|node_modules|backups|reports|dist|coverage)\\'
$Files = @(Get-ChildItem $Root -Recurse -File -Filter "*.md" |
    Where-Object { $_.FullName -notmatch $Excluded })

$Issues = [System.Collections.Generic.List[object]]::new()

foreach ($File in $Files) {
    $Lines = @(Get-Content -LiteralPath $File.FullName)
    $Relative = $File.FullName.Substring($Root.Length).TrimStart('\')

    if ($File.Length -eq 0) {
        $Issues.Add([pscustomobject]@{
            Severity="ERROR"; File=$Relative; Line=1
            Issue="Empty Markdown file"; Detail=""
        })
        continue
    }

    for ($i = 0; $i -lt $Lines.Count; $i++) {
        $Line = $Lines[$i]
        $Number = $i + 1

        # Check standard Markdown links and images.
        foreach ($Match in [regex]::Matches($Line, '!?\[([^\]]*)\]\(([^)]+)\)')) {
            $Target = $Match.Groups[2].Value.Trim()
            $Target = $Target -replace '^(<)(.*)(>)$', '$2'

            if ($Target -match '^(https?://|mailto:|#|data:|tel:)') {
                continue
            }

            $Target = ($Target -split '#')[0] -split '\?' | Select-Object -First 1
            if (-not $Target) { continue }

            $Target = [uri]::UnescapeDataString($Target)
            $Target = $Target.Replace('/', [IO.Path]::DirectorySeparatorChar)
            $Resolved = Join-Path $File.DirectoryName $Target

            if (-not (Test-Path -LiteralPath $Resolved)) {
                $Issues.Add([pscustomobject]@{
                    Severity="ERROR"; File=$Relative; Line=$Number
                    Issue="Broken relative link"; Detail=$Match.Groups[2].Value
                })
            }
        }

        # Flag likely unfinished resource entries.
        # Intentional documentation examples and legitimate placeholder-image
        # services are excluded from this check.
        $isIntentionalExample =
            ($Relative -eq "README.md" -and $Line -match '(?i)\[Resource Name\]\(https://example\.com/\)') -or
            ($Relative -eq "resources\images.md" -and $Line -match '(?i)Lorem Picsum|Placehold\.co') -or
            ($Relative -eq "security\SECURITY-CHECKLIST.md" -and $Line -match '(?i)Documentation examples use placeholder credentials')

        if (
            -not $isIntentionalExample -and
            $Line -match '(?i)TODO|PLACEHOLDER|example\.com|INSERT[_ -]?(URL|LINK)|ADD[_ -]?(VIDEO|LINK)'
        ) {
            $Issues.Add([pscustomobject]@{
                Severity="WARNING"; File=$Relative; Line=$Number
                Issue="Possible placeholder"; Detail=$Line.Trim()
            })
        }

        # Detect malformed explicit HTTP(S) URLs.
        foreach ($Match in [regex]::Matches($Line, 'https?://[^\s\)\]\>\|"''`]+')) {
            $Raw = $Match.Value.TrimEnd('.', ',', ';', ':')
            $Parsed = $null
            if (-not [uri]::TryCreate($Raw, [UriKind]::Absolute, [ref]$Parsed) -or
                $Parsed.Scheme -notin @("http", "https") -or
                -not $Parsed.Host.Contains(".")) {
                $Issues.Add([pscustomobject]@{
                    Severity="ERROR"; File=$Relative; Line=$Number
                    Issue="Malformed URL"; Detail=$Raw
                })
            }
        }
    }
}

$Report = Join-Path $OutDir "resource-validation.md"
$Csv = Join-Path $OutDir "resource-validation.csv"
$Errors = @($Issues | Where-Object Severity -eq "ERROR")
$Warnings = @($Issues | Where-Object Severity -eq "WARNING")

if ($Issues.Count -gt 0) {
    $Issues | Export-Csv -LiteralPath $Csv -NoTypeInformation -Encoding utf8
    $Body = $Issues | ForEach-Object {
        "- **$($_.Severity)** — ``$($_.File):$($_.Line)`` — $($_.Issue): $($_.Detail)"
    }
    $IssueText = $Body -join "`n"
} else {
    $IssueText = "No issues detected by these checks."
}

@"
# Resource Validation Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

- Markdown files scanned: $($Files.Count)
- Errors: $($Errors.Count)
- Warnings: $($Warnings.Count)

## Findings

$IssueText

## Limitations

This validator checks local relative links and URL syntax. It does not prove that
external websites, demo pages, videos, prices, or licenses are currently valid.
Review warnings before removing or changing resources.
"@ | Set-Content -LiteralPath $Report -Encoding utf8

Write-Host "Markdown files scanned: $($Files.Count)"
Write-Host "Errors: $($Errors.Count)" -ForegroundColor $(if ($Errors.Count) {"Red"} else {"Green"})
Write-Host "Warnings: $($Warnings.Count)" -ForegroundColor Yellow
Write-Host "Report: $Report"
if (Test-Path $Csv) { Write-Host "CSV: $Csv" }

if ($Strict -and $Errors.Count -gt 0) {
    exit 1
}

