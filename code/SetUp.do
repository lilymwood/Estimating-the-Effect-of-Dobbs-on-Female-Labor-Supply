* Data Merging

cd "/Users/lilywood/Documents/Honors Thesis (Final)"
use "cps.dta", clear

* MERGE ABORTION INCIDENCE .dta
merge m:1 statefip year using "/Users/lilywood/Documents/Honors Thesis (Final)/AbortionIncidence.dta", gen(merge_abortionincidence)

* MERGE GESTATIONAL LIMIT .dta
merge m:1 statefip year using "/Users/lilywood/Documents/Honors Thesis (Final)/GestationalLimit.dta", gen(merge_gestationallimit)

* Restrict Sample

keep if sex == 2
keep if popstat == 1
keep if inrange(age,15,44)

* Treatment Groups

gen treatment = inlist(statefip,1,5,16,21,22,28,29,38,40,46,47,48,54)
gen post = (year >= 2023)

* Labels

* TREATMENT
label variable treatment "Treatment Group"
label define treatlbl 0 "Control" 1 "Treatment"
label values treatment treatlbl

* AGE
label variable age "Age"

* SEX
label variable sex "Sex"

* RACE
gen race_cat = .

* White
replace race_cat = 1 if race == 100

* Black
replace race_cat = 2 if race == 200

* Native American
replace race_cat = 3 if race == 300

* Asian or Pacific Islander
replace race_cat = 4 if inlist(race, 650, 651, 652)

* Other
replace race_cat = 5 if ///
    race == 700 | ///
    inrange(race, 801, 819) | ///
    inlist(race, 820, 830)

* Missing
replace race_cat = . if race == 999

label define race_cat_lbl ///
    1 "White" ///
    2 "Black" ///
    3 "Native American" ///
    4 "Asian or Pacific Islander" ///
    5 "Other"

label values race_cat race_cat_lbl
label variable race_cat "Race"

* EDUC
gen educ_cat = .

* Less Than High School
replace educ_cat = 1 if inrange(educ, 0, 72)

* High School
replace educ_cat = 2 if educ == 73

* Less Than College
replace educ_cat = 3 if inlist(educ, 80, 81, 90, 91, 92, 100)

* Bachelor's
replace educ_cat = 4 if educ == 111

* Graduate Degree
replace educ_cat = 5 if inrange(educ, 123, 125)

* Missing
replace educ_cat = . if educ == 999

label define educ_cat_lbl ///
    1 "Less Than High School" ///
    2 "High School" ///
    3 "Less Than College" ///
    4 "Bachelor's Degree" ///
    5 "Graduate Degree"

label values educ_cat educ_cat_lbl
label variable educ_cat "Education"

* MARST
gen married = .
replace married = 1 if inlist(marst, 1, 2)
replace married = 0 if inlist(marst, 3, 4, 5, 6, 7)
replace married = . if marst == 9

label variable married "Married"

* NCHILD
label variable nchild "Number of Children in Household"

* NCHLT5
label variable nchlt5 "Number of Children Under 5 in Household"

* POVERTY
gen in_poverty = .
replace in_poverty = 1 if poverty == 10
replace in_poverty = 0 if inlist(poverty,20,21,22,23)

label variable in_poverty "Below Poverty Line"

* EMPSTAT
gen employed = .

* Employed
replace employed = 1 if inlist(empstat, 10, 12)

* Not employed
replace employed = 0 if inlist(empstat, 1, 20, 21, 22, 30, 31, 32, 33, 34, 35, 36)

* Missing
replace employed = . if empstat == 0

label variable employed "Employed"

* LABFORCE
gen in_lf = .
replace in_lf = 1 if labforce == 2
replace in_lf = 0 if labforce == 1
replace in_lf = . if labforce == 0

label variable in_lf "In the Labor Force"
