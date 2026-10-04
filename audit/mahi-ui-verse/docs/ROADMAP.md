# Mahi UI Verse — Product Roadmap

## Vision

Build a trusted, maintainable, searchable directory of useful UI/UX,
design, and frontend-development resources.

## Phase 0 — Clean the catalogue

- [ ] Verify and remove confirmed duplicate entries.
- [ ] Normalize URL conventions.
- [ ] Standardize resource descriptions.
- [ ] Preserve intentional cross-category links.
- [ ] Generate a duplicate report.
- [ ] Review broken internal links.

Exit criteria: duplicates are understood and no useful resource is
removed without a retained canonical entry.

## Phase 1 — Improve resource quality

- [ ] Establish canonical resource metadata.
- [ ] Add verification dates and review status.
- [ ] Review official URLs and demo links.
- [ ] Document license and pricing verification.
- [ ] Improve the contribution guide.
- [ ] Generate CSV and Markdown quality reports.

Exit criteria: resource records have consistent fields and unknown
metadata is explicitly left unknown.

## Phase 2 — Automate maintenance

- [ ] Add duplicate detection to GitHub Actions.
- [ ] Validate local Markdown links.
- [ ] Add Markdown linting where appropriate.
- [ ] Add contribution and pull-request templates.
- [ ] Configure safe dependency update workflows.
- [ ] Avoid flaky external network checks as unconditional blockers.

Exit criteria: new contributions receive repeatable quality checks.

## Phase 3 — Improve discovery

- [ ] Add full-text search.
- [ ] Add category and framework filters.
- [ ] Add use-case tags.
- [ ] Add curated resource collections.
- [ ] Add learning paths.
- [ ] Add verified demo and video directories.
- [ ] Improve mobile navigation and accessibility.

Exit criteria: users can find resources by task, technology, and skill level.

## Phase 4 — Build a resource website

- [ ] Evaluate a static-site or frontend implementation.
- [ ] Generate pages from the canonical catalogue.
- [ ] Add responsive resource cards.
- [ ] Add theme preferences.
- [ ] Add favorites and saved collections.
- [ ] Add related-resource recommendations.
- [ ] Add SEO metadata and social sharing previews.

Do not start this phase until the catalogue and data standards are stable.

## Phase 5 — Community and integrations

- [ ] Resource submission workflow.
- [ ] Duplicate checks during submissions.
- [ ] Maintainer moderation.
- [ ] Broken-link reporting.
- [ ] Contributor recognition.
- [ ] Public JSON export or read-only API.
- [ ] Usage analytics with appropriate privacy safeguards.

## Future metrics

Track actual measurements rather than invented totals:

- Unique canonical resources
- Duplicate candidates
- Confirmed broken URLs
- Resources with verified demos
- Resources with direct tutorial videos
- Records with verified license information
- New resources reviewed per month
- Contribution acceptance rate
- Search success and resource engagement, if analytics are implemented
