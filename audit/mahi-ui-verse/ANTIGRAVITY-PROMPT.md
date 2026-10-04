# Antigravity Prompt — Mahi UI Verse Full Repository Audit

Repository:
https://github.com/mahi-developer-universe/mahi-ui-verse

Act as a senior frontend developer, documentation engineer, open-source
maintainer, and quality automation specialist.

## Objective

Audit the existing repository completely. Identify missing resources,
duplicate URLs, repeated names, broken internal links, incomplete metadata,
placeholder content, missing documentation, and future enhancement
opportunities.

## Safety rules

- Inspect the Git status and current branch first.
- Never discard uncommitted changes.
- Read existing files before editing.
- Preserve useful resources and legitimate cross-category references.
- Never invent links, videos, prices, licenses, or test results.
- Do not rewrite Git history or force-push.
- Do not commit or push without authorization.
- Keep the repository Markdown-first unless a separate product implementation
  is explicitly approved.
- Do not add unnecessary dependencies.
- Back up files before modifying existing user content.

## Duplicate audit

Inspect every Markdown resource catalogue.

Verify known candidates:
- Tailark: entries 35, 84, 96
- Destroy / Spritefusion: entries 81, 101
- Posts Design: entries 75, 112
- Bencho: entries 80, 126
- Best Design Sonx: entries 88, 128
- Zoah: entries 76, 130
- Arc UI / UI Arc: entries 36, 62
- Type Scale / Typescale in resources/fonts.md

Treat these as candidates until independently verified.

Normalize URLs conservatively. Remove tracking parameters only when safe.
Preserve meaningful paths and query parameters. Do not mistake cross-category
references for unwanted duplication.

## Quality audit

Check:
- README accuracy and category coverage
- Missing or broken internal Markdown links
- Inconsistent headings and descriptions
- Empty or unfinished files
- Placeholder links and text
- Missing resource metadata
- Duplicate URLs and names
- Demo and video link quality
- License and pricing documentation
- Contribution instructions
- GitHub Actions workflow quality
- PowerShell compatibility and validation exit codes

## Resource standards

Recommend or implement a consistent canonical resource schema containing:
ID, name, URL, primary category, tags, description, framework, pricing,
license, attribution, demo URL, video URLs, last checked date, and status.

Do not fabricate missing values.

## Automation

Improve the existing scripts/validate-resources.ps1 rather than creating
redundant validators.

Add cross-file duplicate detection, metadata checks, reliable reports,
strict-mode exit codes, and appropriate GitHub Actions integration.

Distinguish blocked, rate-limited, timed-out, redirected, and confirmed
unavailable external URLs.

## Future roadmap

Prioritize:
P0: duplicate cleanup and internal link correctness.
P1: metadata standards and verification.
P2: validation automation and CI.
P3: search, filters, curated collections, demos, and video discovery.
P4: resource website, favorites, public exports, and community submissions.

## Required deliverables

1. Full repository audit report.
2. Confirmed duplicate report with file paths and line numbers.
3. Missing features and documentation report.
4. Improved validation scripts.
5. Data standards.
6. GitHub Actions improvements where necessary.
7. Prioritized roadmap.
8. List of changed, created, and removed files.
9. Actual commands and test results.
10. Remaining manual-review items.

Run the available tests and inspect git diff after every major change.
Do not claim any check passed unless it was executed successfully.
Finish with a concise, actionable summary.
