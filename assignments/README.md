# Workshop Assignments — Nutri-Score Exposed

Three data investigations into why Nutri-Score fails as a guide to healthy eating.
All use the Open Food Facts database (4.5M products) via the `openfoodfacts` skill.

**Format:** Each assignment has two parts. Part 1 (~15 min) gives you a solid finding.
Part 2 (~15 min) goes deeper. Both produce a shareable HTML page.

---

## Choose your investigation

| Assignment | The claim | Best for |
|---|---|---|
| [A — The Mediterranean Trap](a-mediterranean-trap/assignment.md) | Nutri-Score punishes natural foods (olive oil, nuts, cheese) while rewarding industrial alternatives | Clear villain: the algorithm itself |
| [B — The Ultra-Processed A-List](b-ultra-processed-alist/assignment.md) | Thousands of ultra-processed NOVA 4 products carry a green A or B label | Most shocking headline number |
| [C — How Brands Game the System](c-brand-game/assignment.md) | Major brands selectively label only good-scoring products; their worst products hide in plain sight | Most journalistic; follow the brand |

## How to run an assignment

1. Open Claude Code or your Pi agent
2. Point it at the assignment file:
   > *"Follow the instructions in `assignments/a-mediterranean-trap/assignment.md`"*
3. The agent will query the data and build an HTML page
4. Refine, add your own angle, present

**Want to customise first?** Edit the assignment file with your country, brand, or category before referencing it — the investigation will be sharper.

---

*Data: Open Food Facts (ODbL) — attribution required in all outputs.*
*Skill docs: `skills/openfoodfacts/SKILL.md` and `references/story-recipes.md`*
