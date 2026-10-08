# Pull Request Template

## Description
<!-- Provide a brief summary of the changes introduced by this pull request. -->

## Type of Change
- [ ] Add new resource(s)
- [ ] Update / fix existing resource URL or metadata
- [ ] Remove broken / abandoned resource
- [ ] Documentation improvement
- [ ] Script / automation update

## Resource Details (if adding resources)
- **Resource Name**: 
- **Website URL**: 
- **Category**: 
- **License / Pricing**: 

## Verification Checklist
- [ ] The resource is not a duplicate of an existing entry.
- [ ] The URL is live, uses HTTPS, and does not contain tracking parameters.
- [ ] The resource adheres to [Quality Standards](../docs/QUALITY_STANDARDS.md) and [Resource Guidelines](../docs/RESOURCE_GUIDELINES.md).
- [ ] Standard Markdown format has been followed (`1. Name — [https://example.com/](https://example.com/)` or table format).
- [ ] Numbering and alphabetical ordering have been preserved.
- [ ] Local validation passed:
  ```powershell
  ./scripts/validate-resources.ps1
  ./scripts/find-duplicates.ps1
  ```
