# Markdown Style Guide

This style guide defines formatting conventions for all Markdown (`.md`) documents across **Mahi UI Verse**.

---

## 1. Document Headings

- **Single H1 Title**: Every document must start with exactly one `# Document Title` on line 1.
- **Hierarchical Levels**: Use `## H2` for primary divisions and `### H3` for subdivisions. Never skip levels (e.g., jumping from `##` to `####`).
- **Sentence Case / Title Case**: Keep heading titles clear, clean, and concise.

---

## 2. Resource Link Syntax

Always format resource entries using one of two standard styles:

### A. Numbered Directory List Format
Used in [resources/website-directory.md](../resources/website-directory.md) and [resources/new-resources.md](../resources/new-resources.md):

```markdown
1. Resource Name — [https://example.com/](https://example.com/)
```

- Use an em dash (`—`) or hyphen surrounded by single spaces.
- Always wrap the URL in markdown link syntax `[https://example.com/](https://example.com/)`.
- Avoid raw untagged URLs.

### B. Markdown Table Format
Used in category files (e.g., `ui/`, `ux/`, `inspiration/`, `frontend/`):

```markdown
| Resource | URL | Description |
|---|---|---|
| Resource Name | https://example.com/ | Clear concise description of functionality. |
```

- Header separators should use `|---|---|---|` or `|---|---|---:|` for alignment.
- Ensure all rows have equal column counts.

---

## 3. Lists and Checklists

- Use hyphens (`-`) for unordered lists.
- Use standard GitHub markdown task lists for checklists:
  ```markdown
  - [ ] Unfinished task
  - [x] Completed task
  ```

---

## 4. Code Blocks and Quotes

- Wrap code, commands, or script execution examples in fenced code blocks with language identifiers:
  ````markdown
  ```powershell
  ./scripts/validate-resources.ps1
  ```
  ````
- Use blockquotes for important caveats or source provenance notes:
  ```markdown
  > **Note:** Verify licensing and terms before using in commercial projects.
  ```

---

## 5. File Line Endings & Encoding

- All files must be saved with **UTF-8** encoding.
- Ensure all files end with a clean single trailing newline.
