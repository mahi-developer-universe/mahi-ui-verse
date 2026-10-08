# Repository Maintenance Guide

This document describes routine maintenance workflows, validation routines, and auditing procedures for maintainers of **Mahi UI Verse**.

---

## 1. Routine Maintenance Tasks

### Weekly / Bi-Weekly
- **Review Pull Requests & Issues**: Check incoming resource submissions against [docs/RESOURCE_GUIDELINES.md](RESOURCE_GUIDELINES.md) and [docs/QUALITY_STANDARDS.md](QUALITY_STANDARDS.md).
- **Run Duplicate Scans**:
  ```powershell
  ./scripts/find-duplicates.ps1
  ./scripts/audit-near-duplicates.ps1
  ```
- **Update Registry Index**: Re-sync `registry/resources.json` and `registry/resources.csv` using:
  ```powershell
  ./scripts/build-registry.ps1
  ```

### Monthly
- **Periodic Dead Link Audit**: Run `check-links.ps1` to detect 404s, domain expirations, or redirects.
- **Resource Statistics**: Run `resource-stats.ps1` to generate fresh reporting in `reports/resource-stats.md`.
- **Review Category Coverage**: Identify under-represented frontend areas (e.g., modern Web APIs, canvas utilities, accessibility tooling).

---

## 2. Maintenance Script Reference

| Script | Purpose | Output File |
|---|---|---|
| `scripts/validate-resources.ps1` | Comprehensive linting of markdown structure, duplicate names, and link formats | `reports/resource-validation.md` |
| `scripts/validate-metadata.ps1` | Validates completeness of canonical registry metadata | `reports/metadata-validation.md` |
| `scripts/find-duplicates.ps1` | Scans all `.md` files for repeated canonical URLs | `reports/duplicate-urls.md` |
| `scripts/audit-near-duplicates.ps1` | Detects subtle duplicates, trailing slashes, and protocol variances | `reports/near-duplicates.md` |
| `scripts/check-links.ps1` | HTTP status checks across cataloged URLs | `reports/broken-links.md` |
| `scripts/build-registry.ps1` | Extracts parsed resources into JSON & CSV registry | `registry/resources.json`, `registry/resources.csv` |
| `scripts/resource-stats.ps1` | Computes metric counts and unique entries | `reports/resource-stats.md`, `reports/resource-stats.json` |

---

## 3. GitHub Actions CI Pipelines

Automated GitHub Actions enforce quality across every push and pull request:
- **Resource Quality (`.github/workflows/resource-quality.yml`)**: Runs Gitleaks, JSON validation, resource validation, duplicate detection, and link sanity checks.
- **Security (`.github/workflows/security.yml`)**: Scans for secrets and security misconfigurations.
- **Link Check (`.github/workflows/link-check.yml`)**: Scheduled and on-demand link status audits.
- **Markdown Lint (`.github/workflows/markdown-check.yml`)**: Ensures consistent formatting across all markdown documents.
- **Duplicate Check (`.github/workflows/duplicate-check.yml`)**: Fast duplicate verification on pull requests.
