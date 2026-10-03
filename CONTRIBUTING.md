# Contributing to Mahi UI Verse

Thank you for helping improve this UI/UX and frontend resource directory.

## Add a resource

1. Confirm the official URL.
2. Search existing files for the name and URL.
3. Prefer the existing category file.
4. Write a concise description that explains the resource's purpose.
5. Add direct documentation, demo, and video links only when relevant.
6. Verify pricing and licensing claims against official sources.
7. Run the local quality scripts before opening a pull request.

## Quality rules

- Do not add duplicate entries just to increase the resource count.
- Do not label a homepage as an interactive demo unless it demonstrates the product.
- Do not invent video links, pricing, features, or licenses.
- Preserve unique resources when consolidating overlapping entries.
- Report inaccessible links separately from confirmed broken links.
- Avoid committing credentials, `.env` files, backups, build output, or dependency folders.

## Local validation

```powershell
.\scripts\find-duplicates.ps1
.\scripts\validate-resources.ps1
```

Review generated reports under `reports/` before submitting changes.
