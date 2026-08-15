# Estimating the Effect of *Dobbs* on Female Labor Supply

**Undergraduate Honors Thesis in Economics · Tulane University**

This project examines the effect of post-*Dobbs* abortion restrictions on female labor force participation in the United States. Using microdata from the Current Population Survey's Annual Social and Economic Supplement (ASEC), I employ a difference-in-differences design to estimate changes in labor force participation following the implementation of state "trigger laws."

I find no statistically significant effect on female labor force participation in the post-*Dobbs* period. The results are robust to alternative specifications, including a continuous measure of state gestational limits.

### [📄 Read the full thesis](Wood%2C%20Lily-%20Honors%20Thesis.pdf)

## Repository Contents

* `AbortionIncidence.do` — Cleans and reshapes abortion incidence data.
* `GestationalLimits.do` — Cleans and reshapes gestational limit data.
* `SetUp.do` — Builds the main analytic dataset.
* `SummaryStatistics.do` — Creates baseline summary statistics.
* `Regression.do` — Runs the main difference-in-differences regressions.
* `GestationalLimitRegression.do` — Runs continuous policy-measure regressions.
* `Robustness.do` — Runs robustness and heterogeneity checks.
* `EventStudy.do` — Estimates and plots event-study models.


## Software

This project was written in STATA.
