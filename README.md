# Estimating the Effect of *Dobbs* on Female Labor Supply

**Senior Honors Thesis in Economics · Tulane University**

Leveraging cross-state variation in reproductive policy, I designed a difference-in-differences analysis to estimate the effect of *Dobbs v. Jackson Women’s Health Organization* on female labor supply.

### Data

The analysis uses individual-level microdata from the **Current Population Survey Annual Social and Economic Supplement (CPS ASEC)**, paired with state-level information on abortion policy following *Dobbs*.

### Empirical Approach

I compare changes in female labor force participation across states with and without trigger laws before and after the *Dobbs* decision. I also use state gestational limits as a continuous measure of abortion access and conduct a series of robustness checks.

### Findings

I find no statistically significant change in female labor force participation associated with the implementation of trigger laws during the period studied.

### Recognition

**Best Honors Thesis in Economics**
Tulane University Department of Economics

### [📄 Honors Thesis](Lily-Wood-Honors-Thesis.pdf)

## Repository Contents

| File                            | Description                                 |
| ------------------------------- | ------------------------------------------- |
| `SetUp.do`                      | Data preparation and sample construction    |
| `Regression.do`                 | Main difference-in-differences analysis     |
| `Robustness.do`                 | Robustness checks                           |
| `EventStudy.do`                 | Event-study analysis                        |
| `AbortionIncidence.do`          | Analysis using abortion incidence           |
| `SummaryStatistics.do`          | Summary statistics                          |
| `GestationalLimits.do`          | Gestational-limit analysis                  |
| `GestationalLimitRegression.do` | Alternative gestational-limit specification |

## Software

This project was written in STATA.
