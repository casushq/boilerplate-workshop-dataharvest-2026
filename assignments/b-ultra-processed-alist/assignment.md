# Assignment B — The Ultra-Processed A-List

> Nutri-Score judges products on nutrients per 100 g — but ignores *how* they're made.
> A product with 15 additives and an industrial process can score A.
> A whole almond scores C. This is not a bug; it's how the system was designed.

---

## The investigation

Find the "paradox products": ultra-processed (NOVA 4) foods that carry Nutri-Score A or B.
Count them. Name them. Find who makes them.

**Suggested categories to investigate:**

- **Breakfast cereals** — industrial flakes vs. plain oats (dramatic contrast)
- **Fizzy drinks** — diet sodas vs. 100% fruit juice
- **Snack bars / protein bars** — engineered bars vs. dried fruit & nuts
- **Yoghurt** — flavoured low-fat vs. plain full-fat

---

## Part 1 — Count the paradox *(~15 min)*

Tell your agent:

> *"Use the openfoodfacts skill to find all breakfast cereal products that are simultaneously NOVA group 4 (ultra-processed) AND Nutri-Score A or B. How many are there in France? Which brands appear most often? Build an HTML page with: a count of paradox products, a chart showing the grade distribution, and a list of the most prominent examples with their brand names."*

**Swap in your own category** if you have a better story angle — just replace "breakfast cereals" in the prompt.

**What to look for:** Double-digit percentages of ultra-processed products with green labels. A handful of major brands dominating the list.

---

## Part 2 — What's actually in them? *(~15 min, harder)*

Tell your agent:

> *"Now show the other side: minimally processed products (NOVA 1 or 2) in breakfast cereals and their Nutri-Score distribution. Compare the average additive count between NOVA 1–2 and NOVA 4 products in this category. Update the HTML to include: a side-by-side comparison of both groups, and highlight the most extreme examples — NOVA 4 products with 10+ additives that still score A or B."*

**What to look for:** Plain oats (NOVA 1) scoring B or C while sugar-coated puffed cereal with carmine dye scores A. The additive count is your smoking gun.

---

## Sharpen your angle

Before running the agent, consider adding to this file:
- A specific category that surprised you in pre-reading
- A country with a specific cultural context (UK breakfast cereals are notorious)
- A hypothesis: "I think diet drinks are the clearest example" — write that in and the agent will investigate it first

---

*Data: Open Food Facts (ODbL) — include attribution in your output.*
*Skill: `skills/openfoodfacts/SKILL.md` · Methods: `nova_distribution()`, `top_additives()`, custom SQL for NOVA × Nutri-Score crossref*
