# Link Validation & Health Guidelines

Maintaining working, responsive links is critical to the utility of **Mahi UI Verse**. This document details our verification protocols, automated link checks, and error remediation.

---

## 1. Validation Criteria

A link is considered healthy when:
- Resolves with an HTTP `200 OK` status (or acceptable permanent redirect `301`/`308` to its canonical page).
- Has a valid, trusted SSL/TLS certificate.
- Is not parked, expired, or displaying an ad-farm placeholder.
- Contains no syntax errors, spaces, or malformed markdown characters.

---

## 2. Handling HTTP Status Codes & False Positives

Automated link checkers frequently encounter challenges with modern web applications:

| Status Code | Meaning | Policy / Action |
|---|---|---|
| `200 OK` | Healthy & Active | Approved. |
| `301 / 302 / 308` | Redirect | Update the link to its target canonical URL if the redirect is permanent. |
| `403 Forbidden / 401 Unauthorized` | Bot Protection / Cloudflare | **Do not automatically delete.** Many design sites use Cloudflare or WAFs that block command-line crawlers. Manually verify in a browser. |
| `404 Not Found / 410 Gone` | Broken / Removed Page | Candidate for replacement or removal. Verify if the resource migrated. |
| `500 / 502 / 503 / 504` | Server Error | Temporary downtime. Re-check over 48–72 hours before marking as broken. |

---

## 3. Running Link Validation

Contributors and maintainers can execute link checks using the repository automation:

```powershell
# Run the PowerShell link checker
./scripts/check-links.ps1

# Run the comprehensive resource validator
./scripts/validate-resources.ps1 -Strict
```

The validation results will be generated into `reports/broken-links.md` and `reports/resource-validation.md`.

---

## 4. Reporting Broken Links

If you spot a dead link or a domain that has expired or been parked, please submit a report using the [Broken Link Issue Template](../.github/ISSUE_TEMPLATE/broken_link.md).
