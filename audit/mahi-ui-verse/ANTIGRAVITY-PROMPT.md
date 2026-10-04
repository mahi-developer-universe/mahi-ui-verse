# Mahi UI Verse — Professional Repository Audit and Cleanup

Repository:
https://github.com/mahi-developer-universe/mahi-ui-verse

## Role

Act as a senior frontend engineer, open-source maintainer, technical
writer, documentation architect, and quality-engineering specialist.

## Goal

Bring the ENTIRE existing repository to a consistent, professional,
human-written, developer-friendly standard.

The project should be easy to understand, navigate, maintain, contribute
to, and share with the frontend development community.

"Viral" means discoverable, useful, memorable, and shareable. Do not use
fake claims, keyword stuffing, engagement bait, or invented statistics.

## Phase 1 — Inspect before editing

1. Read `git status`, the current branch, and recent commits.
2. Preserve all existing user changes.
3. Inventory every tracked file.
4. Read every README, Markdown resource list, script, JSON/CSV registry,
   JSON Schema, report, workflow, and project policy.
5. Identify malformed content, duplicated responsibilities, inconsistent
   formatting, stale reports, broken internal links, and missing content.
6. Record findings with exact file paths and priorities.
7. Do not claim all files were audited unless they were actually inspected.

## Phase 2 — Resolve the highest-risk issues

### Registry and schema

Inspect:
- `registry/resources.json`
- `registry/resources.csv`
- `registry/schemas/resource.schema.json`
- `registry/SCHEMA.md`
- `scripts/build-registry.ps1`
- `scripts/validate-metadata.ps1`

The registry must conform to the declared schema.

Check types carefully:
- framework: array when defined as an array
- technology: array when defined as an array
- tags: array when defined as an array
- openSource: Boolean, not the strings "True" or "False"
- website and optional URLs: valid URLs when populated
- status, pricing, and license: documented allowed values
- slug and description: populated where required

Unknown information must remain unknown. Do not infer that a resource
is not open source merely because its license has not been checked.

Add actual JSON Schema validation to the workflow. JSON parsing alone
is insufficient.

Fix the registry generator before using it to regenerate canonical data.
It must not replace meaningful metadata with generic values or erase
manually curated fields.

### Suspected file corruption

Inspect `demos/README.md` first. The retrieved content appears to contain
PowerShell generation fragments mixed into Markdown.

Compare its purpose with Git history where useful. Restore or rewrite
the file as a valid demo-directory README. Check other files for similar
accidental script fragments, malformed Markdown, and copied here-strings.

### Duplicate audit tooling

Review:
- `scripts/find-duplicates.ps1`
- `scripts/audit-duplicates.ps1`
- `scripts/audit-near-duplicates.ps1`
- `scripts/check-links.ps1`
- `scripts/build-registry.ps1`
- `scripts/validate-resources.ps1`
- `scripts/validate-metadata.ps1`
- `scripts/resource-stats.ps1`
- `audit/mahi-ui-verse/`

Choose one canonical implementation per responsibility.

Consolidate duplicate documentation and reports where safe. Preserve
unique findings before moving or removing redundant files.

Never automatically delete an entry just because a URL appears in
multiple documentation pages. Distinguish:
- repeated navigation links
- cross-category references
- repeated resource records
- URL aliases
- true duplicate resources

Normalize URLs conservatively. Preserve meaningful paths and query
parameters. Remove tracking parameters only when safe.

## Phase 3 — Make reports trustworthy

Audit generated reports and identify their source scripts and timestamps.

Regenerate reports after fixing the generators. Do not leave stale reports
that contradict current scripts or registry data.

Reports should clearly distinguish:
- verified findings
- suspected issues
- stale data
- manual-review requirements

Do not commit large generated CSVs unless they provide ongoing value.
Respect the repository's reporting and ignore-file conventions.

## Phase 4 — Professional README and documentation

Rewrite the root README into a polished, maintainable project landing page.

Include:
1. Clear project name and value proposition.
2. Concise explanation of who the directory helps.
3. Easy-to-scan category navigation.
4. A small selection of useful featured resources.
5. Honest project statistics generated from canonical data.
6. Clear instructions for browsing and contributing.
7. Quality and verification principles.
8. License and maintainer information.
9. Relevant links to roadmap, contribution guide, and security policy.

Use consistent heading levels, tables, bullets, link labels, terminology,
punctuation, whitespace, and Markdown conventions.

Write in natural, specific English. Remove filler, repetitive claims,
generic AI-sounding descriptions, and unsupported superlatives.

Review and align:
- README.md
- CHANGELOG.md
- ROADMAP.md
- CONTRIBUTING.md
- CODE_OF_CONDUCT.md
- SECURITY.md
- categories/index.md
- registry/INDEX.md
- registry/SCHEMA.md
- registry/API.md
- guides/*
- demos/*
- videos/*
- all category documentation

Do not claim the project has a working public website or API when it is
only documented as a future feature.

## Phase 5 — Resource formatting

Use one consistent format for resource entries.

Recommended Markdown format:

### Resource Name

- **Category:** Specific category
- **Description:** Concise, useful, original explanation
- **Website:** Official URL
- **Documentation:** Direct URL, when verified
- **Demo:** Direct demo URL, when verified
- **GitHub:** Official repository, when verified
- **Video:** Specific relevant video, when available
- **Pricing:** Verified value or Unknown
- **License:** Verified value or Unknown
- **Last verified:** Date only when actually checked

Adapt the format to existing tables when that is more readable. Do not
force every resource to have a demo, video, GitHub repository, or license.

Remove empty placeholder rows. If a category is not yet populated,
say so honestly and provide useful next steps or merge it into a more
appropriate index.

Do not invent resource descriptions, licenses, prices, demos, or videos.

## Phase 6 — Reliable quality automation

Improve validation so it:
- checks local Markdown links
- validates explicit URL syntax
- validates canonical registry JSON against JSON Schema
- validates required metadata and data types
- detects duplicate canonical URLs and IDs
- distinguishes cross-category references from duplicate records
- produces fresh Markdown and CSV reports
- clears or overwrites stale output correctly
- uses meaningful exit codes
- reports errors, warnings, and manual-review cases separately

For external link checking, handle redirects, timeouts, 403, 429, and
servers that reject HEAD requests. Use a careful fallback strategy.
Do not label blocked or rate-limited sites as definitively broken.

Review `.github/workflows/resource-quality.yml` and
`.github/workflows/security.yml`.

Do not silently skip required checks when a script is missing.
Do not add a second workflow that duplicates existing functionality.
Use least-privilege permissions and maintainable action versions.

## Phase 7 — GitHub presentation and discoverability

Recommend a concise repository description and relevant GitHub topics.

Use real workflow badges only when the referenced workflow exists.
Use real license badges only when they match the repository license.
Avoid fake star counts, fake coverage badges, and invented statistics.

Improve search-engine and social sharing presentation through useful
titles, descriptions, clear category names, and original content.

Prioritize developer usefulness over exaggerated marketing language.

## Phase 8 — Validation

Run the available local checks after edits.

At minimum, inspect:
- JSON parsing and JSON Schema validation
- metadata validation
- duplicate audits
- local Markdown links
- Markdown formatting
- Git whitespace errors
- resource statistics
- workflow references to scripts that must exist

Inspect the final Git diff and check that no unrelated user changes were
overwritten. If a test cannot be run, state why. Never claim success
without actual evidence.

## Deliverables

1. Repository-wide audit report.
2. Prioritized issues with exact file paths.
3. Corrected and consistent documentation.
4. Valid canonical registry and schema.
5. Reliable validation scripts and workflows.
6. Consolidated duplicate tooling.
7. Fresh, clearly labeled reports.
8. Updated roadmap and contribution guidance.
9. List of changed, moved, and removed files.
10. Actual test results and remaining manual-review items.

Do not commit, push, force-push, or rewrite Git history without explicit
authorization. Do not delete resource entries without verification.
