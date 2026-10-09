# Mahi UI Verse 🚀

[![Resources: 458 Curated](https://img.shields.io/badge/Resources-458%20Curated-blue.svg)](resources/website-directory.md)
[![Registry: 458 Verified](https://img.shields.io/badge/Registry-458%20Verified-brightgreen.svg)](registry/resources.json)
[![Markdown Validation](https://img.shields.io/badge/Markdown-0%20Errors-success.svg)](reports/resource-validation.md)
[![Metadata Validation](https://img.shields.io/badge/Metadata-Valid-success.svg)](reports/metadata-validation.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Security: Gitleaks](https://img.shields.io/badge/Security-Gitleaks%20Passing-blueviolet.svg)](security/SECURITY-CHECKLIST.md)

**Mahi UI Verse** is a comprehensive, production-grade directory of curated UI/UX platforms, modern frontend component libraries, motion & animation tools, creative utilities, design inspiration, and developer learning platforms. Every resource is tracked with verified canonical metadata across JSON, CSV, and human-readable Markdown directories.

---

## 📑 Table of Contents

- [Overview & Architecture](#-overview-architecture)
- [Quick Links & Registries](#-quick-links-registries)
- [Browse Resource Categories](#-browse-resource-categories)
  - [1. UI Components & Design](#1-ui-components-design)
  - [2. UX & Interaction Design](#2-ux-interaction-design)
  - [3. Frontend Engineering](#3-frontend-engineering)
  - [4. Assets & Developer Resources](#4-assets-developer-resources)
  - [5. Demos, Videos & Tutorials](#5-demos-videos-tutorials)
- [Featured Websites](#-featured-websites)
- [Interactive Developer Games & Practice](#-interactive-developer-games-practice)
- [Developer Data & Future API](#-developer-data-future-api)
- [Documentation & Quality Standards](#-documentation-quality-standards)
- [Contributing](#-contributing)
- [Maintainer & License](#-maintainer-license)

---

## 🏛️ Overview & Architecture

Mahi UI Verse operates with a **Single Source of Truth** architecture:
- **Canonical Registry** (`registry/resources.json`): Machine-readable metadata for all 458 curated tools, including operational status, pricing, license, tags, and canonical links.
- **Derived Formats** (`registry/resources.csv`, `registry/search-index.json`): Automatically generated from the canonical registry for spreadsheet analysis and instant client-side search.
- **Human-Readable Catalogs** (`resources/website-directory.md`, `resources/new-resources.md`, and category files): Synchronized with 100% parity against the registry.
- **CI Automation**: GitHub Actions enforce bidirectional synchronization, link integrity, and strict schema validation on every pull request.

---

## 🔗 Quick Links & Registries

| Resource | Format | Description |
|---|:---:|---|
| **[Master Website Directory](resources/website-directory.md)** | Markdown | Complete alphabetical catalog of 458 verified resources |
| **[Categorized Resource Catalog](resources/new-resources.md)** | Markdown | Numbered and categorized master list |
| **[Canonical Registry (JSON)](registry/resources.json)** | JSON | Canonical source of truth with complete schema metadata |
| **[Canonical Registry (CSV)](registry/resources.csv)** | CSV | Spreadsheet-ready export for tabular workflows |
| **[Client Search Index](registry/search-index.json)** | JSON | Lightweight, compressed index (~131 KB) for client-side search |
| **[API Specification & Contract](registry/API.md)** | Docs | Public RESTful data contract and endpoint specification |
| **[All Categories Index](categories/index.md)** | Docs | Master sitemap of all category folders and documents |
| **[Roadmap](ROADMAP.md)** | Docs | Current milestone status and future platform progression |

---

## 🗂️ Browse Resource Categories

### 1. UI Components & Design

| Category | File Link | Focus & Highlights |
|---|---|---|
| **Component Libraries** | [ui/component-libraries.md](ui/component-libraries.md) | Accessible UI blocks (shadcn/ui, Cult UI, Forge UI, Magic UI) |
| **Design Systems** | [ui/design-systems.md](ui/design-systems.md) | Enterprise design standards (Apple HIG, Material 3, Carbon) |
| **Charts & Data Viz** | [ui/charts.md](ui/charts.md) | Interactive charts and canvas plots (Evil Charts, Tremor, Recharts) |
| **Animations & Motion** | [ui/animations.md](ui/animations.md) | Physics, spring dynamics & micro-interactions (Motion Primitives, GSAP) |
| **UI Generators** | [ui/ui-generators.md](ui/ui-generators.md) | CSS gradients, box-shadows, glassmorphism, and color palettes |
| **Starter Templates** | [ui/templates.md](ui/templates.md) | Production-ready landing, dashboard, and SaaS starters |
| **Web Design Showcases** | [ui/web-showcases.md](ui/web-showcases.md) | 247+ curated award-winning websites & creative design showcases |
| **Landing Pages & SaaS** | [ui/landing-pages.md](ui/landing-pages.md) | High-converting SaaS marketing pages and hero sections |
| **Portfolios & Agencies** | [ui/portfolios.md](ui/portfolios.md) | Creative developer, designer, and agency portfolio showcases |
| **Creative Design Tools** | [ui/creative-tools.md](ui/creative-tools.md) | Online design utilities, SVG tools, and canvas playgrounds |
| **Marketing & Pitch Decks** | [ui/marketing-ui.md](ui/marketing-ui.md) | Pitch decks, investor presentation layouts, and launch UI |
| **Motion Design & 3D** | [ui/motion-design.md](ui/motion-design.md) | Interactive 3D web experiences, easing tools, and WebGL scenes |
| **Branding & Identity** | [ui/branding-design.md](ui/branding-design.md) | Brand identity guidelines, logo libraries, and asset kits |
| **Mobile & App Design** | [ui/mobile-design.md](ui/mobile-design.md) | Mobile UI patterns, iOS/Android screens, and native design archives |
| **UI Patterns & Elements** | [ui/ui-patterns.md](ui/ui-patterns.md) | Micro-interactions, navigation patterns, headers, and footers |

### 2. UX & Interaction Design

| Category | File Link | Focus & Highlights |
|---|---|---|
| **UX Tools & Suites** | [ux/ux-tools.md](ux/ux-tools.md) | End-to-end design and interaction suites |
| **User Flows & Teardowns** | [ux/ux-flows.md](ux/ux-flows.md) | Real-world SaaS onboarding teardowns and screen flows |
| **Wireframing Kits** | [ux/wireframing.md](ux/wireframing.md) | Low-fidelity wireframing and ideation tools |
| **Interactive Prototyping**| [ux/prototyping.md](ux/prototyping.md) | High-fidelity screen transitions and micro-interaction models |
| **User Research & Testing**| [ux/user-research.md](ux/user-research.md) | Heatmaps, session recordings, surveys, and usability feedback |

### 3. Frontend Engineering

| Area | File Link | Scope |
|---|---|---|
| **React** | [frontend/react.md](frontend/react.md) | Hooks, component patterns, and Next.js integrations |
| **TypeScript** | [frontend/typescript.md](frontend/typescript.md) | Type safety, utility types, and strict configurations |
| **JavaScript** | [frontend/javascript.md](frontend/javascript.md) | Modern ECMAScript standards, DOM manipulation, and tooling |
| **CSS & Modern Layouts** | [frontend/css.md](frontend/css.md) | Flexbox, Grid, container queries, CSS variables, and styling |
| **Accessibility (a11y)** | [frontend/accessibility.md](frontend/accessibility.md) | WCAG 2.1/2.2 compliance, screen readers, and ARIA guides |
| **Web Performance** | [frontend/performance.md](frontend/performance.md) | Core Web Vitals, bundle optimization, and page speed profilers |
| **Testing & QA** | [frontend/testing.md](frontend/testing.md) | Unit, E2E, and visual regression testing frameworks |
| **State Management** | [frontend/state-management.md](frontend/state-management.md) | Client and server state libraries (Zustand, TanStack Query) |
| **Developer Tools** | [frontend/developer-tools.md](frontend/developer-tools.md) | DevTools extensions, code formatters, and terminal workflows |
| **Frontend Libraries** | [frontend/libraries.md](frontend/libraries.md) | DOM utilities, animation engines, and helper packages |

### 4. Assets & Developer Resources

| Asset Collection | File Link | Description |
|---|---|---|
| **Icons & Icon Fonts** | [resources/icons.md](resources/icons.md) | Clean SVG, React, and web icon libraries |
| **Typography & Fonts** | [resources/fonts.md](resources/fonts.md) | Variable fonts, typography pairings, and open typefaces |
| **Illustrations** | [resources/illustrations.md](resources/illustrations.md) | Vector illustrations, scene creators, and character sets |
| **Images & Photography**| [resources/images.md](resources/images.md) | High-resolution photography, textures, and stock assets |
| **Free Assets** | [resources/free-assets.md](resources/free-assets.md) | 100% free developer utilities, UI kits, and design freebies |
| **AI Developer Tools** | [resources/ai-tools.md](resources/ai-tools.md) | AI coding tools, design copilots, and generative UI platforms |
| **Git & GitHub** | [resources/git-github.md](resources/git-github.md) | Git workflows, cheatsheets, and interactive exercises |
| **DevOps & Cloud** | [resources/devops.md](resources/devops.md) | CI/CD, containers, serverless platforms, and deployment tools |
| **Master Curated Hub** | [resources/curated-resources.md](resources/curated-resources.md) | Hand-picked featured utilities and high-signal tools |

### 5. Demos, Videos & Tutorials

| Collection | File Link | Description |
|---|---|---|
| **Live Interactive Demos** | [demos/demo-links.md](demos/demo-links.md) | Live component sandboxes, CodePens, and interactive web tools |
| **UI Showcase Videos** | [videos/ui-demos.md](videos/ui-demos.md) | Recorded component animations and visual demonstrations |
| **Frontend Demos** | [videos/frontend-demos.md](videos/frontend-demos.md) | Real-world application implementations and demos |
| **Developer Tutorials** | [videos/tutorials.md](videos/tutorials.md) | Step-by-step frontend and UI engineering tutorials |

---

## 🌟 Featured Websites

A sample of top-tier developer and design tools indexed in the registry:

- **[Evil Charts](https://evilcharts.com/)** — Minimalist, evil-styled interactive SVG/canvas charting components.
- **[Forge UI](https://forgeui.in/)** — Modern design kit and Tailwind CSS component showcase.
- **[Skiper UI](https://skiper-ui.com/)** — High-performance animated UI components for frontend builders.
- **[Cult UI](https://www.cult-ui.com/)** — Radical, high-craft UI components with smooth micro-interactions.
- **[shadcn/ui](https://ui.shadcn.com/)** — Beautifully designed, accessible components built on Radix UI and Tailwind CSS.
- **[21st.dev](https://21st.dev/)** — Curated library of copy-paste components created by the community.
- **[Aceternity UI](https://ui.aceternity.com/)** — Trending animated modern components using Framer Motion & Tailwind CSS.
- **[Magic UI](https://magicui.design/)** — 50+ animated UI components built with React, Typescript, and Tailwind CSS.
- **[Motion Primitives](https://motion-primitives.com/)** — Beautiful, accessible motion components built on top of Framer Motion.
- **[React Bits](https://reactbits.dev/)** — An animated React component collection for rapid interactive prototyping.

---

## 🎮 Interactive Developer Games & Practice

Gamified platforms to practice engineering, command-line skills, security, and DevOps:

- **[Mahi Tools](https://markodenic.com/tools/)** — Comprehensive developer utilities and productivity references.
- **[Oh My Git!](https://ohmygit.org/)** — An open-source, highly visual game designed to master Git operations.
- **[K8s Games](https://k8sgames.com/)** — Interactive Kubernetes challenges and architectural puzzles.
- **[OverTheWire Wargames](https://overthewire.org/wargames/)** — Hands-on security concepts, Linux shell mastery, and command-line CTFs.
- **[CodeCombat](https://codecombat.com/)** — Game-based coding adventures teaching real programming syntax.
- **[DevOps Games](https://devops.games/)** — Gamified puzzles focused on CI/CD, cloud, and DevOps troubleshooting.
- **[picoCTF](https://picoctf.org/)** — Gamified cybersecurity learning platform and computer security competition.

---

## 💻 Developer Data & Future API

Mahi UI Verse is structured to power a future search-driven static web app and public read-only API:

```text
Static Search Payload:
registry/search-index.json (131 KB, minified, indexed by ID, name, description, category, tags, and URL)

Public Read-Only API Contract:
GET /api/v1/resources               # Filter by category, pricing, framework, status
GET /api/v1/resources/:id           # Retrieve full canonical metadata by ID
GET /api/v1/search?q={query}        # Multi-field full-text search
GET /api/v1/stats                   # Real-time counts across categories & licensing
GET /api/v1/random                  # Serendipitous resource discovery
```

For the complete schema contract, allowed values, and integration guides, see **[`registry/API.md`](registry/API.md)** and **[`registry/schemas/resource.schema.json`](registry/schemas/resource.schema.json)**.

---

## 📖 Documentation & Quality Standards

- **[Resource Guidelines](docs/RESOURCE_GUIDELINES.md)** — Inclusion criteria, scope, and editorial guidelines.
- **[Resource Submission Guide](docs/RESOURCE_SUBMISSION.md)** — Step-by-step instructions for submitting new tools.
- **[Quality Standards](docs/QUALITY_STANDARDS.md)** — Curation principles, description standards, and metadata rules.
- **[Duplicate Policy](docs/DUPLICATE_POLICY.md)** — Cross-referencing vs. catalog duplicate resolution policies.
- **[Link Validation](docs/LINK_VALIDATION.md)** — Automated HTTP check parameters and retry mechanisms.
- **[Markdown Style Guide](docs/MARKDOWN_STYLE_GUIDE.md)** — Exact formatting rules for Markdown consistency.
- **[Categories & Architecture](docs/CATEGORIES.md)** — Repository directory structure and taxonomy index.
- **[Repository Maintenance](docs/MAINTENANCE.md)** — Maintainer automation routines and release workflows.
- **[Accessibility (a11y) Guide](ACCESSIBILITY.md)** — WCAG 2.1/2.2 accessibility principles for curated web tools.
- **[Support & Help](SUPPORT.md)** — How to report broken resources or request new collections.
- **[Legal Disclaimer](DISCLAIMER.md)** — Information on third-party links, licensing, and availability.

---

## 🤝 Contributing

We welcome community contributions! Whether you are adding a missing high-quality developer tool, reporting a broken link, or enriching metadata:

1. Check that the resource does not already exist in **[`resources/website-directory.md`](resources/website-directory.md)**.
2. Ensure the website complies with our **[`docs/QUALITY_STANDARDS.md`](docs/QUALITY_STANDARDS.md)**.
3. Open a submission using our structured **[New Resource Issue Template](.github/ISSUE_TEMPLATE/resource-request.yml)**.
4. Review **[CONTRIBUTING.md](CONTRIBUTING.md)** and submit a pull request adhering to our **[Pull Request Template](.github/PULL_REQUEST_TEMPLATE.md)**.

---

## 👩‍💻 Maintainer & License

Maintained with ❤️ by **[Maheswari Pinneti](https://github.com/mahi-developer-universe)** | Frontend Developer

Released under the **[MIT License](LICENSE)**.
