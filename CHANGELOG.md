# Changelog

All notable changes to the **Mahi UI Verse** project are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.1.0] - 2026-10-09

### Added
- **Bidirectional Registry ↔ Markdown Synchronization**: Synchronized 458 curated resources with 100% parity across `registry/resources.json`, `registry/resources.csv`, and `resources/website-directory.md`.
- **Automated Registry Sync Validator**: Added `scripts/validate-registry-sync.ps1 -Strict` ensuring zero missing or orphan entries across Markdown and JSON registries.
- **Client-Ready Static Search Index**: Added `scripts/build-search-index.py` generating a lightweight, compressed index (`registry/search-index.json`, ~131 KB) for immediate web/client-side searching.
- **RESTful API Specification**: Published complete schema, query parameter, and response payload documentation in `registry/API.md`.
- **Duplicate Resource Issue Template**: Added `.github/ISSUE_TEMPLATE/duplicate-resource.yml` GitHub issue form.

### Changed
- **Folder Refactoring**: Completely eliminated legacy `inspiration/` directory; distributed all 392 design inspiration resources into domain-specific categories (`ui/web-showcases.md`, `ui/creative-tools.md`, `ui/portfolios.md`, `ui/marketing-ui.md`, `ui/landing-pages.md`, `ui/ui-patterns.md`, `ui/motion-design.md`, `ui/mobile-design.md`, `ui/branding-design.md`, `ux/ux-flows.md`).
- **Cleaned Placeholder Subdirectories**: Removed empty placeholder subdirectories in `resources/`, eliminating warning noise.
- **Enhanced Duplicate Detection**: Updated `scripts/find-duplicates.ps1` to distinguish between legitimate cross-references (507 instances) and actual catalog duplicates (0 instances).
- **Hardened CI Workflows**: Updated `.github/workflows/resource-quality.yml` and `.github/workflows/link-check.yml` to run strict registry validation and resolve correct report artifact paths.
- **PowerShell Script Accuracy**: Corrected safe array count evaluation in `scripts/resource-stats.ps1` and safeguarded `scripts/build-registry.ps1`.
- **Roadmap & Category Index**: Updated `ROADMAP.md` and `registry/INDEX.md` to accurately reflect verified 458-resource milestones.

---

## [2.0.0] - 2026-10-08

### Added
- Canonical resource schema (`registry/schemas/resource.schema.json`).
- Automated PowerShell quality suites: `validate-metadata.ps1`, `validate-resources.ps1`, `resource-stats.ps1`.
- Interactive developer learning, cybersecurity CTF, and DevOps games directory.
- Full comprehensive contributor guidelines, quality standards, and duplicate resolution policy (`docs/`).
- Gitleaks secret scanning workflow and security checklist (`security/`).
