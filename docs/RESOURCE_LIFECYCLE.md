# Resource Lifecycle Policy

As **Mahi UI Verse** expands into a comprehensive developer and designer registry, each resource transitions through a formalized lifecycle to ensure quality, accurate metadata, and persistent link reliability.

---

## The Lifecycle Pipeline

```text
Proposed ──▶ Reviewed ──▶ Validated ──▶ Published ──▶ Monitored ──▶ Stale ──▶ Updated / Archived
```

---

## 1. Lifecycle Stages

### 1. Proposed (`proposed`)
- **Origin**: Submitted via GitHub Issue ([Resource Request](../.github/ISSUE_TEMPLATE/resource_request.md)), community Pull Request, or discovery bots.
- **Action**: Entry queued for evaluation against [docs/RESOURCE_GUIDELINES.md](RESOURCE_GUIDELINES.md).

### 2. Reviewed (`reviewed`)
- **Criteria**: Assessed for utility, design polish, developer relevance, and license transparency.
- **Action**: Categorized into matching UI/UX domains; duplicates checked against existing catalog.

### 3. Validated (`validated`)
- **Checks**:
  - Live HTTPS status (`200 OK`).
  - Canonical domain verified without affiliate or tracking parameters.
  - License and pricing confirmed from official documentation.
  - Markdown syntax and numbering formatted per [docs/MARKDOWN_STYLE_GUIDE.md](MARKDOWN_STYLE_GUIDE.md).

### 4. Published (`active` / `verified`)
- **Action**: Merged into category markdown files, [resources/website-directory.md](../resources/website-directory.md), and ingested into `registry/resources.json`.
- **Status Value**: `active` or `verified`.

### 5. Monitored (`monitored`)
- **Process**: Continuously audited by automated weekly GitHub Actions link checks (`.github/workflows/link-check.yml`) and duplicate scanners.
- **Health Checks**: Response latency, SSL certificate health, and HTTP redirect verification.

### 6. Stale (`stale` / `needs-review`)
- **Triggers**:
  - Persistent HTTP redirects (`301`/`308`) requiring canonical URL update.
  - Deprecated GitHub repositories (archived or unmaintained for >24 months).
  - Outdated pricing tiers or broken demo sandboxes.
- **Action**: Flagged with `needs-review` in registry metadata.

### 7. Updated or Archived (`redirected` / `archived` / `removed`)
- **Updated**: If a project rebranded or migrated to a new canonical domain, metadata is updated and logged in [CHANGELOG.md](../CHANGELOG.md).
- **Archived**: Historical or significant frameworks that are no longer active but remain valuable for reference.
- **Removed**: Parked domains, dead 404s, malware threats, or spam are purged from all active documentation.
