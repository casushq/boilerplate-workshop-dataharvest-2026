# Assignment A — The Mediterranean Trap · Part 2: The NOVA Paradox

> This is the second part of the Mediterranean Trap investigation.
> **Part 1** (`assignment-part-1.md`) built an HTML page comparing Nutri-Score distributions
> for natural foods vs. industrial counterparts — olive oils vs. vegetable blends,
> nuts vs. chips, hard cheese vs. processed slices. You should have a working HTML output
> with bar charts and a headline finding before starting here.

---

## What Part 1 established

- Nutri-Score grades for olive oils, nuts, and hard cheeses vs. their industrial counterparts
- A bar chart showing the full A–E grade breakdown for each category
- A headline finding about how Nutri-Score treats natural and industrial foods similarly

Now you'll layer in **NOVA processing level** to find the sharpest paradoxes:
foods that are natural (NOVA 1–2) but score badly, and ultra-processed (NOVA 4) foods that score well.

---

## Part 2 — The NOVA paradox *(~15 min, harder)*

Tell your agent:

> *"Now add NOVA processing data to the comparison. Find products that are NOVA 1–2 (minimally processed) but score D or E — and any NOVA 4 (ultra-processed) products that score A or B. Add this to the HTML as a 'paradox products' section. Then do the same for nuts vs. chips-and-fries."*

**What to look for:**
- **Oils**: Coconut oil — NOVA 2, naturally saturated, scores D or E. Flavoured oil spray — NOVA 4, scores B. This is the clearest paradox in the oils category.
- **Nuts vs. chips**: `en:almonds` tends to score A/B (proteins, fibre rewarded). `en:chips-and-fries` tends to score C/D (fat, salt penalised). Here Nutri-Score actually aligns with nutrition science — nuts ARE better. The paradox is explaining *why* it doesn't work the same way for oils.
- **Cheese**: Hard cheeses and processed cheese slices score similarly (C/D) despite vastly different processing levels.

---

## Sharpen your angle

The goal is to find specific *named products* — not just category averages — that illustrate the paradox most sharply. Ask your agent:
- "What is the single most extreme example of a NOVA 2 product with a bad Nutri-Score?"
- "Find me a NOVA 4 product with an A or B grade and show me its ingredient list"

These specific cases make the best story leads.

---

*Data: Open Food Facts (ODbL) — include attribution in your output.*
*Skill: `skills/openfoodfacts/SKILL.md` · Methods: `nutriscore_distribution()`, `nova_distribution()`, custom SQL*
