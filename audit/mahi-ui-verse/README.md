# Mahi UI Verse Audit Toolkit

This directory contains generated audit documentation and scripts.

## Files

- reports/duplicate-audit.md
  Known duplicate candidates and cleanup policy.

- reports/missing-features.md
  Missing feature, quality, and category recommendations.

- scripts/find-duplicates.ps1
  Scans Markdown files for repeated canonical URLs.

- docs/DATA-STANDARDS.md
  Proposed canonical resource metadata.

- docs/ROADMAP.md
  Prioritized future enhancements.

- docs/VALIDATION-AND-CI.md
  Existing validation capabilities and CI recommendations.

- ANTIGRAVITY-PROMPT.md
  Full implementation prompt for Antigravity.

## Run the duplicate scanner

Run from the repository root:

```powershell
.\audit\mahi-ui-verse\scripts\find-duplicates.ps1
```

The script writes:
- audit/mahi-ui-verse/reports/duplicate-scan.md
- audit/mahi-ui-verse/reports/duplicate-scan.csv

## Run existing validation

```powershell
.\scripts\validate-resources.ps1
```

## Review before committing

```powershell
git status --short
git diff --check
```

Generated documentation is a proposal and audit toolkit. It does not
automatically modify or clean the original resource catalogues.
