# Validation and CI Implementation Plan

## Current validator

Review:
scripts/validate-resources.ps1

The existing validator checks:
- Empty Markdown files
- Broken local relative Markdown links
- Likely placeholder content
- Malformed HTTP(S) URLs

It generates Markdown and CSV reports.

## Important limitations

The existing validator does not establish that:
- External websites are reachable
- Videos exist or are accessible
- A demo is a true interactive demo
- Prices are current
- Licenses are accurate
- URLs are duplicates
- All resource descriptions are correct

## Local execution

From the repository root:

```powershell
.\scripts\validate-resources.ps1
```

Strict mode:

```powershell
.\scripts\validate-resources.ps1 -Strict
```

Duplicate scan:

```powershell
.\audit\mahi-ui-verse\scripts\find-duplicates.ps1
```

Review generated reports before making catalogue changes.

## Recommended CI checks

1. Markdown link validation
2. Duplicate URL scan
3. Markdown lint
4. Metadata validation
5. Secret scanning
6. Dependency review where dependencies exist
7. Optional external URL checks with retries and a manual-review status

## CI policy

- Internal broken links should fail CI.
- Confirmed duplicate canonical URLs should be reviewed or fail CI.
- Do not fail solely because an external server returns 403 or 429.
- Use least-privilege workflow permissions.
- Pin third-party actions to reviewed versions or immutable SHAs according to project policy.
- Avoid duplicating existing workflows.
- Do not commit generated local reports unless the repository explicitly intends to version them.
