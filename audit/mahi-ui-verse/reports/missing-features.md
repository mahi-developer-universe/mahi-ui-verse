# Mahi UI Verse — Missing Features and Quality Audit

## Existing foundation

The repository is a Markdown-first directory of UI/UX, frontend,
design, inspiration, developer-tool, demo, and video resources.

Existing documentation includes:
- Component libraries
- Design systems
- Charts and animations
- UI generators and templates
- UX tools
- React, CSS, and JavaScript
- Website and portfolio inspiration
- Icons, fonts, illustrations, and images
- Curated resources
- Demo links and video lists
- Contribution guidance

Existing PowerShell validation checks include local relative Markdown links,
empty Markdown files, likely placeholders, and malformed HTTP(S) URL syntax.

## Priority 0 — Catalogue correctness

- Remove confirmed duplicate entries.
- Normalize canonical URLs.
- Standardize resource names.
- Review duplicate resources across all Markdown files.
- Preserve legitimate category cross-listing.
- Check that internal Markdown links resolve.
- Review incomplete descriptions and placeholder content.

## Priority 1 — Resource metadata

- Stable resource ID
- Canonical URL
- Primary category
- Optional secondary categories
- Search tags
- Description
- Framework and technology
- Pricing status
- License and attribution
- Official demo URL
- Direct tutorial video URL
- Last verification date
- Verification status

Do not fabricate unknown values.

## Priority 2 — Discovery and usability

- Search by resource name and description
- Filter by category and framework
- Filter by free, freemium, and paid status
- Filter by license where known
- Search by use case
- Recently added resources
- Recently verified resources
- Curated collections
- Related resources
- Beginner, intermediate, and advanced learning paths

## Priority 3 — Demos and video quality

- Prefer direct interactive demo URLs.
- Distinguish homepage URLs from actual demos.
- Prefer individual tutorial videos over generic channel links.
- Record video duration only when verified.
- Record creator and publication date only when verified.
- Never invent missing links.
- Mark unavailable demos for review.

## Priority 4 — Automation

- Cross-file duplicate detection
- Canonical URL normalization
- Metadata completeness checks
- External-link checking with retry and timeout handling
- Markdown linting
- CI validation
- CSV and Markdown reports
- Pull-request templates
- Automated validation of new contributions

## Priority 5 — Product enhancements

- Responsive searchable resource website
- Resource cards and preview images
- Dark and light themes
- Favorites and saved collections
- Resource comparison
- User-submitted resources
- Moderation and approval workflow
- Broken-link reporting
- Contributor profiles
- Public read-only API
- Machine-readable JSON export
- Changelog and public roadmap

## Additional categories to assess

- Accessibility and WCAG
- Frontend performance and Core Web Vitals
- Component and visual regression testing
- Forms and schema validation
- Tables and data grids
- Maps, WebGL, and 3D
- React Native and mobile UI
- Design handoff and design tokens
- API integration and authentication UI
- Open-source contribution guides
- Frontend project challenges
- Interview preparation
- AI-assisted UI development

These are recommendations to evaluate against the complete repository, not
claims that every category is absent.
