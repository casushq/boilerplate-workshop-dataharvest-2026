# Assignment C — How Brands Game the System

> Nutri-Score is voluntary. Brands choose whether to display it — product by product.
> The incentive is obvious: label the products that score well; skip the label for everything else.
> What does a major brand's *full* portfolio actually look like when nothing is hidden?

---

## The investigation

Generate a complete brand profile using the Open Food Facts database — all products, all scores, no cherry-picking. Then look for the gap between the products a brand promotes and the ones they'd prefer you didn't see.

**Suggested brands to put on trial:**

| Big food | "Healthy" brands to verify |
|---|---|
| Nestlé | Bjorg |
| Kellogg's | Innocent |
| Danone | Activia |
| Dr. Oetker | Quaker |
| Unilever | A local health brand you know |

---

## Part 1 — The brand showcase *(~15 min)*

Tell your agent:

> *"Showcase Nestlé using the openfoodfacts skill. Open the output in my browser."*

That's the full prompt. The skill generates a complete HTML brand profile automatically — Nutri-Score distribution, NOVA breakdown, worst products, controversial additives, country presence.

Once you have it, find your story:
- What % of their portfolio scores D or E?
- What are their worst three products by Nutri-Score?
- What % of products are ultra-processed (NOVA 4)?
- Write down 2–3 headline findings to present.

**Swap in any brand name** — just replace "Nestlé" with your chosen brand.

---

## Part 2 — The comparison *(~15 min, harder)*

Tell your agent:

> *"Now compare Nestlé to Bjorg (or another brand you choose). For each brand: what % of products score D or E on Nutri-Score? What % are NOVA 4? Which brand has the biggest spread between their best and worst products? Build a side-by-side HTML comparison page with charts for both brands."*

**What to look for:** Does the "healthy" brand actually perform better, or is it a halo effect? Is there a brand with a suspiciously high % of products with *no* Nutri-Score at all — a transparency gap?

---

## Sharpen your angle

Before running the agent, consider adding to this file:
- The specific brand(s) you want to investigate
- A hypothesis: "I think Danone hides behind Activia's health image" — add it and the agent will test it
- A specific product category to focus on (e.g., Kellogg's cereals only)
- Your country market (French market data is richest; Dutch and German data also strong)

---

*Data: Open Food Facts (ODbL) — include attribution in your output.*
*Skill: `skills/openfoodfacts/SKILL.md` · Methods: `generate_brand_showcase()`, `brand_comparison()`, `worst_products_by_brand()`*
