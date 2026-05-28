---
name: design
description: "Design system and visual style guide for any web output produced during the workshop. Apply this skill whenever building a web page, dashboard, data visualisation page, HTML report, or any UI — regardless of what the content is about. Triggers on: create a web page, build a website, make a dashboard, HTML output, web app, landing page, visualisation page, make it look good, style this, add CSS, design a page, build a UI, create an interface. This skill defines the complete CSS base, token system, and component patterns to use. Do NOT generate ad-hoc CSS or Bootstrap/Tailwind — use the tokens and patterns here."
---

## Purpose

Any web page you produce during this workshop should use this design
system. It gives a consistent, readable, data-first aesthetic that works
well for journalistic output, data tables, analysis results, and simple
interactive tools.

**Key rules:**
- Use the CSS base and tokens below — do not invent colours, sizes, or
  fonts ad hoc.
- Do not import Bootstrap, Tailwind, or other CSS frameworks.
- Inline all CSS in a `<style>` block in the `<head>` — no separate
  `.css` file required unless the project grows beyond one page.
- Google Fonts (Inter + JetBrains Mono) are loaded from
  `fonts.googleapis.com`. No download needed.

---

## Aesthetic

Dense, dark-first, data-forward. Reference: Linear / Vercel / Supabase
Studio — tools used by people who need to read information quickly, not
marketing sites.

- **Zinc neutrals, single green accent.** `#00C853` means "active /
  passing / good". Everything else is zinc greys. Red means failure,
  amber means warning.
- **Mono for data, sans for prose.** IP addresses, numbers, codes,
  timestamps, file paths, shell commands, and machine-generated values
  → JetBrains Mono. Headings, labels, body copy → Inter.
- **Flat.** 1 px borders, 4 px radius, no drop shadows (shadows are for
  floating layers like dropdowns — use them only then).
- **Dark by default, light mode supported.** CSS `prefers-color-scheme`
  switches the colour tokens automatically. The layout and spacing do
  not change.

---

## CSS base — copy this into every page

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Page title</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap">
  <style>
    /* --- tokens -------------------------------------------------------- */
    :root {
      --font-sans: "Inter", system-ui, sans-serif;
      --font-mono: "JetBrains Mono", ui-monospace, Menlo, monospace;

      --bg:           #fafafa;
      --bg-elev:      #ffffff;
      --bg-subtle:    #f4f4f5;
      --fg:           #18181b;
      --fg-dim:       #71717a;
      --fg-muted:     #a1a1aa;
      --border:       #e4e4e7;
      --border-soft:  #f4f4f5;

      --accent:       #00C853;
      --accent-soft:  rgba(0, 200, 83, 0.10);
      --ok:           #16a34a;
      --warn:         #d97706;
      --fail:         #dc2626;

      --radius: 4px;
      --pad:    16px;
      --gap:    10px;
    }

    @media (prefers-color-scheme: dark) {
      :root {
        --bg:          #0a0a0a;
        --bg-elev:     #0f0f10;
        --bg-subtle:   #131316;
        --fg:          #d4d4d8;
        --fg-dim:      #a1a1aa;
        --fg-muted:    #71717a;
        --border:      #27272a;
        --border-soft: #1c1c1f;
        --accent-soft: rgba(0, 200, 83, 0.14);
      }
    }

    /* --- reset & base -------------------------------------------------- */
    *, *::before, *::after { box-sizing: border-box; }

    html, body {
      margin: 0;
      background: var(--bg);
      color: var(--fg);
      font-family: var(--font-sans);
      font-size: 15px;
      line-height: 1.5;
      -webkit-font-smoothing: antialiased;
    }

    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    main {
      flex: 1;
      width: 100%;
      max-width: 900px;
      margin: 0 auto;
      padding: 32px var(--pad);
    }

    /* wider canvas for dashboards / data-heavy pages */
    body.wide main { max-width: 1200px; }

    /* --- typography ----------------------------------------------------- */
    h1 { font-size: 20px; font-weight: 600; letter-spacing: -0.02em; margin: 0 0 var(--pad); }
    h2 { font-size: 11px; font-weight: 500; text-transform: uppercase;
         letter-spacing: 0.08em; color: var(--fg-dim);
         margin: 28px 0 var(--gap); }
    h3 { font-size: 15px; font-weight: 600; margin: var(--pad) 0 var(--gap); }
    p  { margin: var(--gap) 0; }

    .hint  { color: var(--fg-dim); font-size: 13px; }
    .label { font-size: 11px; font-weight: 500; text-transform: uppercase;
             letter-spacing: 0.08em; color: var(--fg-dim); }

    a { color: var(--fg); text-decoration: none;
        border-bottom: 1px solid var(--border); }
    a:hover { color: var(--accent); border-bottom-color: var(--accent); }

    /* --- mono surfaces -------------------------------------------------- */
    code, kbd, pre, .mono {
      font-family: var(--font-mono);
      font-size: 13px;
    }

    code {
      background: var(--bg-subtle);
      border: 1px solid var(--border-soft);
      padding: 1px 5px;
      border-radius: var(--radius);
    }

    pre {
      background: #0a0a0a;       /* always dark — terminal aesthetic */
      border: 1px solid #27272a;
      color: #e4e4e7;
      padding: 12px 14px;
      border-radius: var(--radius);
      overflow-x: auto;
      margin: var(--gap) 0 var(--pad);
      line-height: 1.5;
    }
    pre code { background: none; border: 0; padding: 0; color: inherit; }

    kbd {
      background: var(--bg-elev);
      border: 1px solid var(--border);
      border-bottom-width: 2px;
      border-radius: var(--radius);
      padding: 2px 6px;
      font-size: 12px;
      color: var(--fg-dim);
    }

    /* --- tables --------------------------------------------------------- */

    /* data table: full-width, 38 px rows, column headers */
    table.data {
      width: 100%;
      border-collapse: collapse;
      font-size: 13px;
      border: 1px solid var(--border);
      border-radius: var(--radius);
      overflow: hidden;
      font-variant-numeric: tabular-nums;
    }
    table.data th {
      text-align: left;
      padding: 0 14px;
      height: 38px;
      background: var(--bg-subtle);
      font-size: 11px;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.08em;
      color: var(--fg-dim);
      border-bottom: 1px solid var(--border);
    }
    table.data td {
      padding: 0 14px;
      height: 38px;
      vertical-align: middle;
      border-bottom: 1px solid var(--border-soft);
    }
    table.data tr:last-child td { border-bottom: 0; }
    table.data tbody tr:hover   { background: var(--bg-subtle); }

    /* detail table: key–value pairs, no outer border */
    table.detail { font-size: 13px; border-collapse: collapse; }
    table.detail th {
      text-align: left;
      padding: 6px 20px 6px 0;
      width: 10rem;
      font-size: 12px;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.04em;
      color: var(--fg-dim);
      vertical-align: top;
    }
    table.detail td {
      padding: 6px 0;
      font-family: var(--font-mono);
    }

    /* --- stat / KPI tiles ----------------------------------------------- */
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 1px;
      background: var(--border);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      overflow: hidden;
      margin: var(--pad) 0;
    }
    .stat {
      background: var(--bg-elev);
      padding: var(--pad);
    }
    .stat .stat-label {
      font-size: 11px;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.08em;
      color: var(--fg-dim);
      margin-bottom: 6px;
    }
    .stat .stat-value {
      font-family: var(--font-mono);
      font-size: 24px;
      font-weight: 500;
      letter-spacing: -0.02em;
      color: var(--fg);
      font-variant-numeric: tabular-nums;
    }
    .stat .stat-hint { font-size: 12px; color: var(--fg-dim); margin-top: 4px; }
    .stat-value.ok   { color: var(--ok); }
    .stat-value.warn { color: var(--warn); }
    .stat-value.fail { color: var(--fail); }

    /* --- status badges -------------------------------------------------- */
    .badge {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 0 10px;
      height: 22px;
      border-radius: var(--radius);
      font-size: 12px;
      font-weight: 500;
      font-family: var(--font-mono);
      border: 1px solid var(--border);
      background: var(--bg-elev);
      color: var(--fg-dim);
      text-transform: lowercase;
    }
    .badge::before {
      content: "";
      display: inline-block;
      width: 6px; height: 6px;
      border-radius: 999px;
      background: var(--fg-muted);
    }
    .badge-ok::before   { background: var(--accent);
                          box-shadow: 0 0 0 2px var(--accent-soft); }
    .badge-fail::before { background: var(--fail); }
    .badge-warn::before { background: var(--warn); }
    .badge-ok   { color: var(--fg); }
    .badge-fail { color: var(--fail); }
    .badge-warn { color: var(--warn); }

    /* --- inline status dot (inside table cells) ------------------------- */
    .dot {
      display: inline-block;
      width: 7px; height: 7px;
      border-radius: 999px;
      background: var(--fg-muted);
      margin-right: 8px;
      vertical-align: 1px;
    }
    .dot-ok   { background: var(--accent);
                box-shadow: 0 0 0 2px var(--accent-soft); }
    .dot-fail { background: var(--fail); }
    .dot-warn { background: var(--warn); }

    /* --- cards ---------------------------------------------------------- */
    .card {
      background: var(--bg-elev);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: var(--pad);
      margin: var(--gap) 0;
    }
    .card > *:first-child { margin-top: 0; }
    .card > *:last-child  { margin-bottom: 0; }

    /* --- forms ---------------------------------------------------------- */
    label {
      display: block;
      margin-bottom: 6px;
      font-size: 12px;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.04em;
      color: var(--fg-dim);
    }
    input[type="text"],
    input[type="search"],
    input[type="number"],
    select,
    textarea {
      width: 100%;
      padding: 0 10px;
      height: 34px;
      background: var(--bg-elev);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      font-size: 15px;
      font-family: var(--font-sans);
      color: var(--fg);
      transition: border-color 80ms;
    }
    textarea { height: auto; padding: 8px 10px; }
    input:focus, select:focus, textarea:focus {
      outline: none;
      border-color: var(--accent);
      box-shadow: 0 0 0 3px var(--accent-soft);
    }
    button, .btn {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      height: 34px;
      padding: 0 14px;
      background: var(--fg);
      color: var(--bg);
      border: 1px solid var(--fg);
      border-radius: var(--radius);
      font-size: 14px;
      font-family: var(--font-sans);
      font-weight: 500;
      cursor: pointer;
      transition: opacity 80ms;
      text-decoration: none;
    }
    button:hover, .btn:hover { opacity: 0.85; border-bottom: none; }

    .btn-ghost {
      background: transparent;
      color: var(--fg-dim);
      border-color: var(--border);
    }
    .btn-ghost:hover { color: var(--fg); border-color: var(--fg-muted); }

    /* --- inline alerts -------------------------------------------------- */
    .alert {
      padding: 10px 12px;
      border-radius: var(--radius);
      border: 1px solid var(--border);
      font-size: 13px;
      margin: var(--gap) 0;
    }
    .alert-ok   { border-left: 3px solid var(--ok);   color: var(--ok); }
    .alert-warn { border-left: 3px solid var(--warn);  color: var(--warn); }
    .alert-fail { border-left: 3px solid var(--fail);  color: var(--fail); }
  </style>
</head>
<body>
  <main>
    <!-- page content here -->
  </main>
</body>
</html>
```

---

## Component patterns

### When to use each table variant

**`table.data`** — any list of records: search results, product tables, data
exports, leaderboards. Bordered outer, 38 px rows, hover highlight.

**`table.detail`** — metadata for a single subject: product profile, summary
of findings, key-value pairs from an API response. No outer border; reads
like a form.

### Stat tiles (`.stats` + `.stat`)

Use for KPI summaries at the top of a page: totals, percentages, averages.
Grid auto-fits; add as many tiles as needed. Mark the most important number
`.stat-value.ok` (green) or `.stat-value.fail` (red) if it carries a signal.

```html
<div class="stats">
  <div class="stat">
    <div class="stat-label">Products analysed</div>
    <div class="stat-value">4,490,000</div>
    <div class="stat-hint">EU27 + UK dataset</div>
  </div>
  <div class="stat">
    <div class="stat-label">NOVA 4 rate</div>
    <div class="stat-value warn">34%</div>
    <div class="stat-hint">ultra-processed</div>
  </div>
</div>
```

### Badges

Use for status labels in tables or next to headings. Always lowercase.

```html
<span class="badge badge-ok">passing</span>
<span class="badge badge-fail">error</span>
<span class="badge badge-warn">pending</span>
<span class="badge">unknown</span>
```

### Dots

Use inline in table cells when a full badge would be too heavy — boolean
checks, yes/no states.

```html
<span class="dot dot-ok"></span> active
<span class="dot dot-fail"></span> inactive
```

### Cards

Wrap any self-contained block of content: a chart + its caption, a code
snippet + explanation, a filter form.

```html
<div class="card">
  <h3>Top additives in French sodas</h3>
  <!-- chart or table here -->
  <p class="hint">n = 1,203 products with additive data</p>
</div>
```

### `pre` blocks

Always dark. Use for shell commands, code snippets, raw data samples. The
dark-on-every-theme rule is intentional — it reads as a terminal.

```html
<pre><code>duckdb food.parquet "SELECT COUNT(*) FROM food"</code></pre>
```

### Mono rule

Any value that comes from data or a machine → `font-family: var(--font-mono)`.
This means: numbers in stat tiles, product names in results tables, barcodes,
E-numbers, version strings. Apply via the `table.detail td` default or
with `.mono` on individual elements.

---

## Page-level classes

| `<body>` class | Effect             | When to use                        |
|----------------|--------------------|------------------------------------|
| *(none)*       | 900 px max-width   | Articles, reports, single-subject  |
| `wide`         | 1200 px max-width  | Dashboards, wide data tables       |

---

## Charts and visualisations

When generating charts (matplotlib, Plotly, Chart.js, or plain SVG):

- **Background:** transparent or `--bg`. Embed in a `.card`.
- **Gridlines:** `--border` colour, 0.5–1 px.
- **Axis text:** `--fg-dim` colour, JetBrains Mono if possible.
- **Bars / lines / points:** use the semantic palette first:
  - Good / positive: `#00C853` (accent)
  - Neutral: `#71717a` (zinc-500)
  - Warning: `#d97706`
  - Bad / negative: `#dc2626`
  - Categorical series: zinc shades (`#d4d4d8`, `#a1a1aa`, `#71717a`,
    `#52525b`) before introducing any other colour.
- **Always include:** a finding-based title (state the insight, not just
  the data), sample size annotation, and data attribution.
- **Nutri-Score official colours** (when applicable):

  ```python
  NUTRISCORE_COLORS = {
      'a': '#038141', 'b': '#85BB2F', 'c': '#FECB02',
      'd': '#EE8100', 'e': '#E63E11',
  }
  ```

- **NOVA colours** (when applicable):

  ```python
  NOVA_COLORS = {1: '#4CAF50', 2: '#8BC34A', 3: '#FF9800', 4: '#F44336'}
  ```

  These override the neutral palette — Nutri-Score and NOVA have
  established colours that readers expect.

---

## What not to do

- **No arbitrary hex values.** Use tokens. If a colour you need is not in
  the token set, use the closest semantic token.
- **No `font-size` below 11 px.** If content does not fit, reduce the
  content, not the type size.
- **No `box-shadow` on flat surfaces.** Shadows signal floating layers
  (dropdowns, tooltips, modals). A card or a table row is not floating.
- **No gradients as background.** Gradients can appear in chart fills when
  data requires it. Never on page background or card fills.
- **No more than one accent colour per page.** `#00C853` is the signal.
  Adding a second accent dilutes it.
- **No Bootstrap, Tailwind, or utility-class frameworks.** They fight the
  token system and produce inconsistent output.

---

## Quick-start checklist

When you start building any web output, confirm:

- [ ] Paste the CSS base above into `<head>`.
- [ ] Fonts loaded from Google Fonts (Inter + JetBrains Mono).
- [ ] All colours from CSS tokens — no hex literals outside the `:root` block.
- [ ] Numbers and machine values in `.mono` / `font-family: var(--font-mono)`.
- [ ] Charts have finding-based titles, sample size annotations, attribution.
- [ ] `body.wide` on dashboards; plain `body` on article/report pages.
- [ ] No Bootstrap, Tailwind, or other framework imports.
