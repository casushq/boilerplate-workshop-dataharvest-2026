# Assignment A — The Mediterranean Trap

> Nutri-Score penalises some of the world's most celebrated healthy foods.
> Olive oil scores C or D. Nuts fare worse than potato chips in some categories.
> Meanwhile, diet soda earns a B. Can you prove it with data?

---

## The investigation

Compare Nutri-Score grades for Mediterranean staples vs. their industrial counterparts, then cross-reference with NOVA processing levels to expose the full absurdity.

**Suggested pairs to investigate:**

| Natural food | Industrial counterpart |
|---|---|
| Olive oil | Vegetable/sunflower oil blends |
| Nuts & almonds | Potato chips / crisps |
| Hard cheese (Parmesan, Manchego, Gruyère) | Processed cheese slices |
| Cured ham / prosciutto | Deli meat / reformed ham |

Pick one pair or all of them.

---

## Part 1 — The score comparison *(~15 min)*

Tell your agent:

> *"Use the openfoodfacts skill to compare Nutri-Score distributions for olive oils vs. vegetable oils in France. Show the full A–E grade breakdown for each category. Which one scores better on average? Build a clean HTML page with a bar chart for each comparison and a headline finding."*

**Suggested focus:** France (`en:france`) has the most data. Swap in your own country if you prefer.

**What to look for:** Olive oils concentrated in C/D while industrial blends cluster in B/C.

---

## Part 2 — The NOVA paradox *(~15 min, harder)*

Tell your agent:

> *"Now add NOVA processing data to the same comparison. Find products in olive oils and vegetable oils that are NOVA 1–2 (minimally processed) but score D or E — and any NOVA 4 products that score A or B. Add this to the HTML as a 'paradox products' section. Then do the same for nuts vs. potato chips."*

**What to look for:** The inverted pyramid — the more natural the food, the lower its score. An industrial product with additives scoring higher than pressed olives or raw almonds is your headline.

---

## Sharpen your angle

Before running the agent, consider editing this file to add:
- A specific country you want to focus on
- A specific product you already know is egregious (e.g., a premium olive oil you recognise)
- A comparison that matters to your audience (e.g., cheese in an Italian context)

The agent will pick up any context you add above.

---

*Data: Open Food Facts (ODbL) — include attribution in your output.*
*Skill: `skills/openfoodfacts/SKILL.md` · Methods: `nutriscore_distribution()`, `nova_distribution()`, custom SQL*
