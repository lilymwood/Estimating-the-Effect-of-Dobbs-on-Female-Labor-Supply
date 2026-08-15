# Estimating the Effect of *Dobbs* on Female Labor Supply

**Undergraduate Honors Thesis in Economics · Tulane University**

This project examines the effect of post-*Dobbs* abortion restrictions on female labor force participation in the United States. Using microdata from the Current Population Survey's Annual Social and Economic Supplement (ASEC), I employ a difference-in-differences design to estimate changes in labor force participation following the implementation of state "trigger laws."

I find no statistically significant effect on female labor force participation in the post-*Dobbs* period. The results are robust to alternative specifications, including a continuous measure of state gestational limits.

### [📄 Honors Thesis](Lily-Wood-Honors-Thesis.pdf)


## Replication Code

This repository contains the Stata code used to produce the empirical analysis in the thesis.

| File                            | Description                                 |
| ------------------------------- | ------------------------------------------- |
| `SetUp.do`                      | Data preparation and sample construction    |
| `SummaryStatistics.do`          | Summary statistics                          |
| `Regression.do`                 | Main difference-in-differences estimates    |
| `EventStudy.do`                 | Event-study analysis                        |
| `Robustness.do`                 | Robustness checks                           |
| `GestationalLimitRegression.do` | Alternative gestational-limit specification |
| `AbortionIncidence.do`          | Analysis using abortion incidence           |


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
