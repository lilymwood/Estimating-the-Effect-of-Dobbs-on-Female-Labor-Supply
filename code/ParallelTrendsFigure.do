* Import Data

cd "/Users/lilywood/Documents/Honors Thesis (Final)"
use cps.dta, clear

* Restrict Sample

keep if sex == 2
keep if popstat == 1
keep if inrange(age,15,44)

* Treatment Group

gen treatment = inlist(statefip,1,5,16,21,22,28,29,38,40,46,47,48,54)

* Labels

label variable treatment "Treatment Group"
label define treatlbl 0 "Control" 1 "Treatment"
label values treatment treatlbl

* Create FLFPR & Post

gen flfpr = (labforce==2)
collapse (mean) flfpr, by(treatment year)
gen post = (year >= 2023)

* Motivating Figure (2015-2025)

scatter flfpr year if treatment==0 & inrange(year,2015,2025) || scatter flfpr year if treatment==1 & inrange(year,2015,2025) || lfit flfpr year if treatment==0 & inrange(year,2015,2022) || lfit flfpr year if treatment==0 & inrange(year,2023,2025) || lfit flfpr year if treatment==1 & inrange(year,2015,2022) || lfit flfpr year if treatment==1 & inrange(year,2023,2025)

* Motivating Figure (2010-2025)

scatter flfpr year if treatment==0 & inrange(year,2010,2025) || scatter flfpr year if treatment==1 & inrange(year,2010,2025) || lfit flfpr year if treatment==0 & inrange(year,2010,2022) || lfit flfpr year if treatment==0 & inrange(year,2023,2025) || lfit flfpr year if treatment==1 & inrange(year,2010,2022) || lfit flfpr year if treatment==1 & inrange(year,2023,2025)
