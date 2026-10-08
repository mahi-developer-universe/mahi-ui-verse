# Resource Taxonomy & Tagging Guide

A standardized taxonomy ensures consistency across the JSON/CSV registry, markdown tables, search systems, and future website filters.

---

## 1. Primary Domains (`category`)

Every entry in Mahi UI Verse belongs to one primary category:

| Category Slug | Category Title | Primary Focus |
|---|---|---|
| `ui` | UI Components & Kits | Web components, design systems, UI libraries, animations, generators |
| `ux` | User Experience | Wireframing, prototyping, user testing, interaction design |
| `frontend` | Frontend Development | Frameworks, languages, performance, testing, devtools, state management |
| `inspiration` | Design Inspiration | Web galleries, landing pages, SaaS showcases, portfolios, mobile UI |
| `resources` | Creative Assets | Icons, fonts, illustrations, graphics, audio, stock media |
| `developer-tools` | Developer Utilities | IDE extensions, CLI tools, regex testers, git utilities, formatters |
| `ai-tools` | AI & Generative Tools | AI coding, UI generators, image synthesis, prompt design |

---

## 2. Standardized Resource Types (`type`)

- `library`: Code packages, npm modules, or installable components.
- `component-system`: Comprehensive design system or component suite (e.g., shadcn/ui, Radix).
- `tool`: Interactive web application, online editor, generator, or converter.
- `gallery`: Visual inspiration showcase or design archive.
- `asset`: Downloadable SVG, font, icon set, or illustration pack.
- `documentation`: Official documentation, reference specification, or cheat sheet.
- `learning`: Interactive coding game, course, or sandbox.

---

## 3. Tagging Standards (`tags`)

Tags must be lowercase, alphanumeric, and hyphenated. Format as semicolon-separated or array values.

### Common Tag Taxonomies:
- **Frameworks**: `react`, `vue`, `svelte`, `nextjs`, `nuxt`, `astro`, `remix`, `vanilla-js`, `tailwind`
- **Styling**: `css`, `scss`, `css-in-js`, `headless`, `glassmorphism`, `dark-mode`
- **Capabilities**: `animation`, `charts`, `data-viz`, `icons`, `typography`, `generator`, `color-palette`
- **Standards**: `accessibility`, `wcag-aa`, `screen-reader`, `keyboard-nav`, `responsive`
- **Licensing**: `open-source`, `mit`, `apache-2.0`, `free`, `freemium`, `commercial`

---

## 4. Metadata Schema Example

```json
{
  "name": "Evil Charts",
  "canonicalUrl": "https://evilcharts.com",
  "category": "ui",
  "subcategory": "charts",
  "type": "library",
  "tags": ["charts", "data-visualization", "react", "ui"],
  "platform": "web",
  "pricing": "free",
  "openSource": true,
  "hasDemo": true,
  "hasVideo": false,
  "license": "MIT",
  "status": "verified"
}
```
