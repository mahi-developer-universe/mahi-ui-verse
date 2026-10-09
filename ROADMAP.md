# 🚀 Mahi UI Verse Roadmap

## PHASE 1 — FOUNDATION
- [x] Directory architecture & documentation
- [x] Canonical resource schema (`registry/schemas/resource.schema.json`)
- [x] JSON canonical registry (`registry/resources.json`)
- [x] CSV derived registry (`registry/resources.csv`)
- [x] Quality policy & guidelines (`docs/`)
- [x] Contribution guide & issue forms (`.github/ISSUE_TEMPLATE/`)
- [x] PR template & code of conduct
- [x] Security policy & Gitleaks secret scanning

## PHASE 2 — CLEANUP & CATEGORY CONSOLIDATION
- [x] Duplicate URL audit & cross-reference classification
- [x] 0 duplicate names in canonical registry
- [x] Normalized canonical URLs
- [x] Eliminated legacy `inspiration/` folder and distributed into `ui/`, `ux/`, `resources/`
- [x] Cleaned placeholder subdirectories and aligned category structure

## PHASE 3 — DATA QUALITY & SYNCHRONIZATION
- [x] Canonical registry ↔ Markdown bidirectional sync (458 ↔ 458)
- [x] Automated registry sync validator (`scripts/validate-registry-sync.ps1`)
- [x] Metadata validator with zero errors/warnings (`scripts/validate-metadata.ps1`)
- [x] Resource statistics generator (`scripts/resource-stats.ps1`)
- [x] Added `lastVerified` and operational status tracking
- [ ] Regular batch re-verification of external availability

## PHASE 4 — CONTENT SCALE
- [x] 250 verified resources
- [x] 450+ verified resources (currently at 458 canonical entries)
- [ ] 600 verified resources
- [ ] 1000+ verified resources

## PHASE 5 — MEDIA & ASSET ENRICHMENT
- [x] Direct live demos for 458 resources
- [x] Component video showcase playlists
- [ ] Direct preview screenshots / OpenGraph asset caching
- [ ] Expand verified GitHub repo mappings

## PHASE 6 — AUTOMATION & CI
- [x] GitHub Actions resource quality workflow (`resource-quality.yml`)
- [x] Automated strict registry sync validation in CI
- [x] Automated duplicate checking workflow
- [x] Markdown link syntax & file validation
- [x] Link health check workflow
- [ ] Automatic broken-link issue filing bot
- [ ] GitHub API repository stars / activity enrichment

## PHASE 7 — STATIC SEARCH INDEX & WEBSITE
- [x] Lightweight search index generator (`scripts/build-search-index.py` -> `registry/search-index.json`)
- [x] Public API specification & schema contract (`registry/API.md`)
- [ ] Client-side search interface (Fuse.js / Pagefind web UI)
- [ ] Category, technology, and pricing filter UI
- [ ] Favorites & community collections
- [ ] Dark / Light modern frontend design

## PHASE 8 — PLATFORM & COMMUNITY
- [x] Community resource submission via GitHub issue forms
- [x] Broken-link reporting templates
- [ ] Contributor spotlight & hall of fame
- [ ] Monthly trending resources digest

---

**Mahi UI Verse → The Developer-Friendly Open Source UI/UX Resource Discovery Platform**
