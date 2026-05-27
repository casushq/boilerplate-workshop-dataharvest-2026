# Workshop Slides — Nutri-Score Exposed
## DataHarvest 2026

---

### Slide 1 — Title

# Nutri-Score: Is It Broken?

**An investigation using 4.5 million food products**

*DataHarvest 2026 · Open Food Facts Workshop*

---

### Slide 2 — What is Nutri-Score?

- Front-of-pack **A–E label** adopted in France, Netherlands, Germany, Spain, Belgium
- Rates products **per 100 g** on nutrients: sugar, salt, saturated fat, fibre, protein
- **Voluntary** — brands choose whether to display it, and on which products
- Does **not** account for how food is processed (NOVA)
- Calculated from a proprietary algorithm; updated in 2024 creating chaos

---

### Slide 3 — Why it's broken: three stories

🫒 **Olive oil gets C/D.** It's pressed olives. Diet soda gets B. It's water + artificial sweeteners.

🏭 **1 in 10 ultra-processed products** (NOVA 4) still score A or B — the system can't tell the difference between a protein shake with 15 additives and a boiled egg.

🏷️ **Brands play the game.** Nutri-Score is voluntary. Companies display it on their good products. Their worst products stay unlabelled.

---

### Slide 4 — Your assignment (choose one)

**🫒 A — The Mediterranean Trap**
Prove that Nutri-Score penalises natural traditional foods while rewarding industrial substitutes.
→ Olive oil vs. vegetable blends · Nuts vs. chips · Hard cheese vs. processed slices

**🏭 B — The Ultra-Processed A-List**
Find the paradox products: NOVA 4, ultra-processed — yet Nutri-Score A or B.
→ Breakfast cereals · Diet drinks · Protein bars · What brands dominate the list?

**🏷️ C — How Brands Game the System**
Generate a full brand portfolio profile. Find the products they'd never voluntarily label.
→ Nestlé, Kellogg's, Danone — or a "healthy" brand you want to verify

---

### Slide 5 — How to run it

1. Open **Claude Code** or your **Pi agent**
2. Say: *"Follow the instructions in `assignments/[a/b/c]-[name]/assignment.md`"*
3. The agent queries 4.5M products and builds an **HTML page** with charts
4. Refine with your own angle — the files are editable
5. **Present your headline finding** in 2 minutes

**Part 1** (~15 min) → solid, presentable finding
**Part 2** (~15 min) → deeper, more specific story

---

### Slide 6 — Tips for a good investigation

- **Pick a country** to focus the data — France has the most products (~2M)
- **Always ask the agent to report sample sizes** — "80% of products" needs an n
- **The story lives in the gap** — natural food scoring worse than industrial, healthy label on junk food
- **Don't stop at the first result** — ask the agent "what's the most extreme example?"
- **Missing data is a story too** — which categories have no Nutri-Score coverage at all?

---

### Slide 7 — Data notes

**Open Food Facts** is the world's largest open food database
→ 4.5 million products · 150 countries · citizen-contributed · ODbL licence

**Coverage caveats** (always mention in your story):
- ~40–50% of products have a Nutri-Score
- ~30–40% have NOVA classification
- France is over-represented; results vary by country

**Attribution required:** *"Data: Open Food Facts (openfoodfacts.org), Open Database Licence (ODbL)"*

---

*Assignment files in `boilerplate-workshop-dataharvest-2026/assignments/`*
