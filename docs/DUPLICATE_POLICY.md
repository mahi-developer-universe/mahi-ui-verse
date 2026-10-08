# Duplicate Resource Policy

A high-quality directory must remain free of clutter, redundant mirrors, and accidental duplicates. This policy clarifies how duplicates are identified, audited, and resolved in **Mahi UI Verse**.

---

## 1. What Constitutes a Duplicate?

1. **Exact URL Duplicates**: Identical URLs appearing more than once within the same list or directory.
2. **Canonical Domain / Path Duplicates**: URLs that point to the exact same content regardless of protocol (`http` vs `https`), subdomain (`www.` vs naked domain), or trailing slashes (`/`).
3. **Mislabeled Resources**: An identical URL filed under two different names (e.g., `Lapa Ninja` pointing to `siteinspire.com` when `siteInspire` is already present).
4. **Redundant Parameter Duplicates**: Links that differ only by tracking parameters (`?utm_medium=...`, `?ref=...`).

---

## 2. Legitimate Multi-Occurrences (Allowed Exceptions)

Resources may appear across different files when fulfilling different architectural roles:
- **Central Navigation vs. Category File**: A tool (e.g., `shadcn/ui`) may be featured on the root `README.md` and also cataloged within `ui/component-libraries.md` and `resources/website-directory.md`.
- **Distinct Sub-Tools on the Same Domain**:
  Multiple tools under the same domain are **explicitly allowed** if they provide distinct utilities. For example:
  ```text
  https://www.cssdesignawards.com/
  https://www.cssdesignawards.com/sites/the-ride/50163/
  ```
  Or:
  ```text
  https://bestwebsitetemplate.com/templates/shopify/couture
  https://bestwebsitetemplate.com/templates/framer/origo-studio
  ```
- **Platform Collections**: Different repositories or packages hosted on the same multi-tenant platform (e.g., different GitHub repositories, Apple App Store tools, or Vercel deployments).

---

## 3. Automated Duplicate Auditing

Contributors and maintainers can audit duplicates locally using our repository scripts:

```powershell
# Scans all Markdown files and reports duplicate canonical URLs
./scripts/find-duplicates.ps1

# Audits near-duplicates and normalized domains
./scripts/audit-near-duplicates.ps1

# Generates global resource stats and duplicate counts
./scripts/resource-stats.ps1
```

Audit reports are automatically written to `reports/duplicate-urls.md` and `reports/duplicate-urls.csv`.
