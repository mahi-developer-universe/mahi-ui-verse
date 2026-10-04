# Mahi UI Verse — Duplicate Resource Audit

Repository: https://github.com/mahi-developer-universe/mahi-ui-verse

## Confirmed duplicate candidates

| Resource | Entries in resources/new-resources.md | Action |
|---|---|---|
| Tailark | 35, 84, 96 | Retain one canonical entry |
| Destroy / Spritefusion | 81, 101 | Retain one; standardize the name |
| Posts Design | 75, 112 | Retain one |
| Bencho | 80, 126 | Retain one |
| Best Design Sonx | 88, 128 | Retain one |
| Zoah | 76, 130 | Retain one |
| Arc UI / UI Arc | 36, 62 | Retain one canonical record |
| Type Scale / Typescale | Inspect resources/fonts.md | Merge if the destination is identical |

These candidates were identified from the previously inspected resource list.
The scanner must independently verify them against the current checkout.

## Cross-category duplicates

A resource appearing in the README, featured collection, and category list
is not automatically an error. Prefer a single canonical resource record
with references from multiple categories.

## URL normalization rules

1. Trim surrounding whitespace.
2. Normalize hostname casing.
3. Remove URL fragments for duplicate comparison.
4. Ignore known tracking parameters, such as utm_source and utm_campaign.
5. Normalize trailing slashes where appropriate.
6. Preserve meaningful query parameters.
7. Preserve different paths as separate candidates.
8. Never treat similar names alone as proof of duplication.

## Manual review required

- Redirects and URL aliases.
- Different tools hosted on the same domain.
- Resources with distinct product pages.
- URLs that require authentication.
- Sites that block automated requests.

## Acceptance criteria

- No unexplained duplicate canonical URLs.
- All removed entries have a retained destination.
- Cross-category references remain usable.
- Reports include source file and line number.
