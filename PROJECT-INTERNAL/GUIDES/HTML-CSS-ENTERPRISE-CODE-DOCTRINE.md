# HTML & CSS ENTERPRISE CODE DOCTRINE

**Document Class:** 001-01/25-GUIDE
**Version:** 2.0 (Unified)
**Date:** 2026-02-08
**Scope:** Binding standards for Frontend Engineering (HTML, CSS, Vanilla JS)
**Target Engine:** Blink, Gecko, WebKit (Latest)

---

## PREAMBLE: THE ILLUSION OF SPEED

**Problem Statement:**
Modern web development has drifted into decadence. We ship megabytes of JavaScript to render text. We tolerate layout shifts that frustrate users. We hide content from search engines behind loading spinners. This creates "fragile" experiences that fail on slow networks, drain batteries, and are invisible to scrapers.

**Our Solution:**
We practice **Digital Brutalism** in engineering.
1.  **HTML is the API:** It is the source of truth for structure.
2.  **CSS is the Engine:** It handles layout and visual state efficiently.
3.  **JavaScript is a Bonus:** It enhances the experience but is never required for core consumption.

---

## PART I: THE SKELETON (HTML & SEMANTICS)

### ARTICLE 1: THE "NO-JS" FUNCTIONALITY RULE

**1.1 The Scraper Test**
Every page **must** function and display its core content with JavaScript **disabled**.
*   **Rationale:** Googlebot, Bingbot, LLM scrapers, and accessibility tools often run without JS or with limited JS budgets. If your content isn't in the initial HTML response, it doesn't exist.
*   **Enforcement:** During development, disable JavaScript in DevTools. If the page is blank or broken, the PR is rejected.

**1.2 Semantic Rigor**
`<div>` is a generic container of last resort.
*   ❌ **BAD:** `<div class="nav">`, `<div class="article">`, `<div class="button" onclick="...">`
*   ✅ **GOOD:** `<nav>`, `<article>`, `<button type="button">`
*   **Why?** Semantic elements provide free accessibility hooks and SEO signals that `div`s lack.

### ARTICLE 2: ACCESSIBILITY (WCAG 2.1+)

**2.1 The First Rule of ARIA**
"The first rule of ARIA is: Don't use ARIA."
If a native HTML element exists (`<button>`, `<input type="checkbox">`), use it. Only use ARIA (`role="button"`) when absolutely necessary to retrofit complex widgets.

**2.2 Visual Order = DOM Order**
Do not use CSS (`flex-direction: row-reverse` or `order`) to drastically disconnect the visual layout from the DOM order. Screen readers follow the DOM.

**2.3 Focus Management**
Everything interactive must be:
1.  Focusable (`tabindex="0"`).
2.  Visible on focus (`outline` must never be `none` without a replacement).
3.  Operable via Keyboard (`Enter`/`Space`).

### ARTICLE 3: SEO & STRUCTURED DATA

**3.1 The Head Order**
The `<head>` is not a dumping ground. Order matters for parsing speed.
1.  Preconnects (`<link rel="preconnect">`)
2.  Critical CSS (Inline or sync)
3.  Preloads (`<link rel="preload">`) - *Use sparingly*
4.  Async/Defer Scripts
5.  Meta Tags / SEO

**3.2 JSON-LD (The API for Robots)**
Every entity (Article, Product, Organization, Breadcrumb) must be defined in `application/ld+json` blocks in the head. This is how we speak directly to the search engine database, bypassing the need for them to parse visual HTML.

---

## PART II: THE VISUAL ENGINE (CSS ARCHITECTURE)

### ARTICLE 4: ARCHITECTURE CHOICES

We support two, and only two, CSS architectures. Mixing them is forbidden.

#### OPTION A: TAILWIND CSS (Latest/v4.0+)
*   **Engine:** Rust-based JIT engine.
*   **Constraint:** Zero runtime generation.
*   **Configuration:** Strict `tailwind.config.js`. No arbitrary values (`w-[123px]`) allowed in production code; define them in the theme.
*   **Goal:** 0kb unused CSS. The JIT compiler ensures we only ship exactly what is used.

#### OPTION B: ITCSS (Inverted Triangle CSS)
For projects requiring raw CSS (rare), we use **ITCSS**.
1.  **Settings:** Global variables, colors, fonts.
2.  **Tools:** Mixins and functions.
3.  **Generic:** Reset, Normalize.
4.  **Elements:** Unclassed HTML elements (`h1`, `a`).
5.  **Objects:** OOCSS objects (Layout, Wrappers).
6.  **Components:** Specific UI chunks (Buttons, Cards).
7.  **Trumps:** Helpers, overrides (`!important`).

### ARTICLE 5: ZERO LAYOUT SHIFT (CLS)

**5.1 Aspect Ratios are Mandatory**
Every `<img>`, `<video>`, or `<iframe>` **MUST** have explicit `width` and `height` attributes or a CSS `aspect-ratio` defined before the asset loads.
*   ❌ **BAD:** Loading an image and letting it push content down when it renders.
*   ✅ **GOOD:** Reserving the exact pixel space before the network request starts.

**5.2 Font Loading Strategy**
*   **Rule:** `font-display: swap` is mandatory.
*   **Advanced:** Use `size-adjust` metrics in `@font-face` to match the fallback font's x-height to the web font, eliminating the "text jitter" when the font swaps.

**5.3 Dynamic Content**
If injecting content via JS (e.g., ads, comments), you must pre-allocate a container with a fixed `min-height`.

### ARTICLE 6: RENDER PERFORMANCE (MINIMAL CALCS)

**6.1 The Composite Layer**
Animations must only touch `transform` and `opacity`.
*   ❌ **FORBIDDEN:** Animating `left`, `top`, `width`, `height`, `margin`. (Triggers Layout/Reflow = Slow CPU).
*   ✅ **REQUIRED:** Animating `transform: translate()`, `transform: scale()`. (Triggers Composite = Fast GPU).

**6.2 Containment**
Use the CSS `contain` property (`contain: content` or `contain: strict`) on complex isolated widgets (like sidebars or infinite lists). This tells the browser: "Nothing inside this box affects the layout outside." It prunes the render tree calculations massively.

---

## PART III: THE INTERACTIVE LAYER (JAVASCRIPT)

### ARTICLE 7: PROGRESSIVE ENHANCEMENT

**7.1 The Bonus Layer**
JavaScript is treated as an enhancement layer.
*   **Menus:** Must work with `:hover` or `:focus-within` CSS, or a checkbox hack for mobile, *before* JS takes over for a polished experience.
*   **Forms:** Must submit via standard HTTP POST if JS fails. JS simply intercepts the `submit` event to upgrade it to AJAX.

**7.2 Third-Party Scripts (The Trojan Horse)**
Third-party scripts (Analytics, Chat, Pixels) are the primary cause of slow sites.
*   **Rule:** Never load non-critical third-party scripts in the `<head>`.
*   **Strategy:** Use "Facading". Load a static button for the Chat Widget. Only inject the heavy Chat JS code when the user *hovers* or *clicks* the button.

### ARTICLE 8: SCRIPT LOADING STRATEGY

**8.1 Defer by Default**
*   ❌ `<script src="...">`: Blocks parsing. Forbidden.
*   ❌ `<script async src="...">`: Downloads parallel, executes immediately (interrupting HTML parsing). Use only for totally independent scripts (Analytics).
*   ✅ `<script defer src="...">`: Downloads parallel, executes **after** HTML parsing, in order. **This is the default.**

---

## PART IV: ASSET OPTIMIZATION

### ARTICLE 9: THE ABOVE-THE-FOLD RULE

**9.1 Critical Rendering Path**
Content within the first 1000px (desktop) / 600px (mobile) is **Sacred**.
1.  CSS for this region must be inline or loaded first.
2.  LCP (Largest Contentful Paint) image must be `rel="preload"` and **NOT** `loading="lazy"`.
3.  Everything below the fold must be `loading="lazy"` and `content-visibility: auto`.

**9.2 Image Formats**
*   **Default:** WebP or AVIF.
*   **Fallback:** JPG/PNG inside a `<picture>` tag.
*   **Vector:** SVG must be inline if small (icons) to save an HTTP request.

---

## PART V: TOOLING & ENFORCEMENT

### ARTICLE 10: THE BUILD PIPELINE

Even "Vanilla" projects require a build step to ensure strictness.

**10.1 PostCSS / LightningCSS**
We use `LightningCSS` (Rust-based) for minification and autoprefixing. It is significantly faster than standard PostCSS.

**10.2 Node Modules Hygiene**
*   **Rule:** `node_modules` must never be deployed.
*   **Process:** The build artifact is a clean `dist/` folder containing only HTML, CSS, JS, and Assets.
*   **Linting:**
    *   **HTML:** `html-validate` (Strict accessibility rules).
    *   **CSS:** `stylelint` (Enforcing ordering and no-unused-css).
    *   **JS:** `eslint` (No inline event handlers).

### ARTICLE 11: HOSTING & CACHING

**11.1 Cache-Control**
*   **Immutable Assets (Hashed):** `Cache-Control: public, max-age=31536000, immutable`.
*   **HTML Files:** `Cache-Control: public, max-age=0, must-revalidate`. (Forces browser to check server for updates, ensuring users never see stale content).

**11.2 Compression**
Brotli (br) is mandatory. Gzip is the fallback.

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (Unified Doctrine)
