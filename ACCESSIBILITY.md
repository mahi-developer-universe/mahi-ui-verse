# Accessibility Policy & Guidelines (a11y)

**Mahi UI Verse** is committed to supporting accessible digital experiences and advancing web accessibility best practices across modern UI/UX design and frontend development.

---

## 1. Web Content Accessibility Guidelines (WCAG) Awareness

We prioritize resources, UI components, and design systems that champion **WCAG 2.1 & 2.2 (Level AA/AAA)** conformance.

When evaluating frontend components, look for:
- **Perceivable**: Text alternatives for non-text content, adaptable structure, sufficient color contrast, and audio/video transcripts.
- **Operable**: Full keyboard accessibility, sufficient time to interact, seizure prevention (e.g., respecting `prefers-reduced-motion`), and predictable navigation.
- **Understandable**: Clear readability, consistent UI patterns, and descriptive input error messages.
- **Robust**: Clean semantic HTML compatible with assistive technologies and screen readers.

---

## 2. Core Accessibility Pillars for UI/UX Resources

### Keyboard Navigation & Focus Management
- Interactive elements (buttons, dialogs, dropdowns, tabs) must be focusable via `Tab` and operable via `Enter`/`Space`/arrow keys.
- Visible focus rings (`:focus-visible`) must never be suppressed without an accessible alternative.
- Modals, drawers, and popovers must trap focus appropriately and restore focus to trigger elements upon dismissal (`Escape`).

### Color Contrast & Typography
- Text and interactive elements must satisfy contrast minimums:
  - Normal text: At least **4.5:1** contrast ratio against its background.
  - Large text (18pt / 14pt bold): At least **3:1** contrast ratio.
  - UI components and graphical objects: At least **3:1** against adjacent colors.
- Never convey state or information purely through color (e.g., pair colors with icons or labels).

### Accessible Components & Design Systems
We specifically highlight accessible component foundations, including:
- **Radix UI / shadcn/ui**: Built on accessible primitives with WAI-ARIA authoring compliance.
- **React Aria / Adobe Spectrum**: High-fidelity accessibility behaviors, keyboard navigation, and internationalization.
- **Headless UI**: Unstyled accessible UI components designed to pair with modern CSS.

### Screen Reader Considerations
- Valid semantic HTML tags (`<nav>`, `<main>`, `<header>`, `<footer>`, `<aside>`, `<button>`, `<input>`) must take precedence over generic `<div>` wrappers.
- Accurate ARIA attributes (`aria-expanded`, `aria-label`, `aria-describedby`, `aria-hidden`) must be applied only when necessary (first rule of ARIA: use native HTML elements whenever possible).

---

## 3. Accessible Resource Tagging

In this repository's catalog, resources that excel in accessibility are tagged with `accessibility`, `a11y`, or `wcag-compliant` within the metadata registry.

Contributors are encouraged to indicate accessibility compliance (e.g., WCAG Level AA, keyboard-navigable, screen-reader tested) when submitting component libraries or tools.

---

## 4. Reporting Accessibility Issues

If you discover accessibility barriers in any documentation, markdown tables, navigation links, or tools maintained within this repository:
- Open an issue on GitHub with the label `accessibility`.
- Provide details on the affected screen reader, browser, assistive device, or contrast challenge.
- We treat accessibility bugs with high priority and welcome community improvements.
