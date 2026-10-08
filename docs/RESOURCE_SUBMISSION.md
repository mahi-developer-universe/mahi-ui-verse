# Resource Submission Guide

We welcome submissions from the community! Follow this guide to submit new UI/UX tools, libraries, or design inspiration sites to **Mahi UI Verse**.

---

## Submission Checklist

Before submitting a Pull Request or issue, make sure you have:

- [ ] Verified that the resource does not already exist in [resources/website-directory.md](../resources/website-directory.md) or [ui/web-showcases.md](../ui/web-showcases.md).
- [ ] Confirmed that the website is active and uses HTTPS.
- [ ] Verified that the resource is relevant to UI, UX, frontend development, design inspiration, or developer productivity.
- [ ] Formatted the entry using standard Markdown syntax.

---

## Submission Format

When proposing a resource in an issue or PR, provide the following fields:

```markdown
### Resource Details
- **Name**: Resource Name
- **Category**: (e.g., UI Components, Animations, Web Showcases, Typography, Generators)
- **Website**: https://example.com/
- **Demo / Documentation**: https://example.com/docs (if applicable)
- **GitHub Repository**: https://github.com/org/repo (if open source)
- **License**: (e.g., MIT, Apache-2.0, Proprietary, Free for Personal Use)
- **Pricing**: (e.g., Free, Freemium, Paid)
- **Description**: A concise, 1–2 sentence explanation of what the resource provides.
```

---

## How to Submit via Pull Request

1. **Fork** the repository and create a branch for your addition (`git checkout -b feat/add-resource-name`).
2. Add the resource entry to the appropriate file:
   - For general websites and tools: Add to [resources/website-directory.md](../resources/website-directory.md) in its correct alphabetical position.
   - For web design showcases: Add to [ui/web-showcases.md](../ui/web-showcases.md).
   - For component libraries or category-specific collections: Add to the appropriate markdown file under `ui/`, `ux/`, `frontend/`, or `resources/`.
3. Run local validation:
   ```powershell
   ./scripts/validate-resources.ps1
   ./scripts/find-duplicates.ps1
   ```
4. Commit your changes with a conventional commit message:
   ```bash
   git commit -m "feat(resources): add Resource Name"
   ```
5. Open a Pull Request referencing the checklist in our [Pull Request Template](../.github/PULL_REQUEST_TEMPLATE.md).
