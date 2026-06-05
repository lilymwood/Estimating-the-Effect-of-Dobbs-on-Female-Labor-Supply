* Robustness and Design Checks
* Outcome: Female Labor Force Participation / Employment

cd "/Users/lilywood/Documents/Honors Thesis (Final)"

do "/Users/lilywood/Documents/Honors Thesis (Final)/SETUP.do"

capture which esttab
if _rc ssc install estout

* Restrict to analysis window used in motivating figure
keep if inrange(year, 2015, 2025)



* Table 1: Baseline window restriction (2015-2025)

eststo clear

eststo m1: regress in_lf i.treatment##i.post, vce(robust)
eststo m2: regress in_lf i.treatment##i.post, vce(cluster statefip)
eststo m3: regress in_lf i.treatment##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress in_lf i.treatment##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_2015_2025_InLF.rtf", replace ///
    keep(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treatment "Treatment" ///
        1.post "Post" ///
        1.treatment#1.post "Treatment x Post" ///
        age "Age" ///
        2.race_cat "Black" ///
        3.race_cat "Native American" ///
        4.race_cat "Asian or Pacific Islander" ///
        5.race_cat "Other" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to 2015-2025.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: Labor Force Participation, 2015-2025")



* Table 2: Black women only

preserve
keep if race_cat == 2

eststo clear

eststo m1: regress in_lf i.treatment##i.post, vce(robust)
eststo m2: regress in_lf i.treatment##i.post, vce(cluster statefip)
eststo m3: regress in_lf i.treatment##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress in_lf i.treatment##i.post ///
    age i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_BlackWomen_InLF.rtf", replace ///
    keep(1.treatment 1.post 1.treatment#1.post age 2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat ///
         married nchild nchlt5 in_poverty) ///
    order(1.treatment 1.post 1.treatment#1.post age 2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat ///
          married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treatment "Treatment" ///
        1.post "Post" ///
        1.treatment#1.post "Treatment x Post" ///
        age "Age" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to Black women ages 15-44, 2015-2025.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: Black Women and Labor Force Participation")

restore



* Table 7: Alternative treatment group (6-week-or-tighter bans)

preserve

capture drop treat6
bysort statefip: egen treat6 = max(post == 1 & gl <= 6)
label variable treat6 "6-Week-or-Tighter Ban State"

eststo clear

eststo m1: regress in_lf i.treat6##i.post, vce(robust)
eststo m2: regress in_lf i.treat6##i.post, vce(cluster statefip)
eststo m3: regress in_lf i.treat6##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress in_lf i.treat6##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_Treat6_InLF.rtf", replace ///
    keep(1.treat6 1.post 1.treat6#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(1.treat6 1.post 1.treat6#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treat6 "Treatment" ///
        1.post "Post" ///
        1.treat6#1.post "Treatment x Post" ///
        age "Age" ///
        2.race_cat "Black" ///
        3.race_cat "Native American" ///
        4.race_cat "Asian or Pacific Islander" ///
        5.race_cat "Other" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to 2015-2025.", ///
        "Treatment group defined as states that ever have a gestational limit of 6 weeks or less in the post-Dobbs period.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: 6-Week-or-Tighter Ban Treatment Group and Labor Force Participation")

restore



* Table 3: Alternative treatment group (excluding MO and ND)

preserve
replace treatment = inlist(statefip, 1, 5, 16, 21, 22, 28, 40, 46, 47, 48, 54)

eststo clear

eststo m1: regress in_lf i.treatment##i.post, vce(robust)
eststo m2: regress in_lf i.treatment##i.post, vce(cluster statefip)
eststo m3: regress in_lf i.treatment##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress in_lf i.treatment##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_AltTreatment_InLF.rtf", replace ///
    keep(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treatment "Treatment" ///
        1.post "Post" ///
        1.treatment#1.post "Treatment x Post" ///
        age "Age" ///
        2.race_cat "Black" ///
        3.race_cat "Native American" ///
        4.race_cat "Asian or Pacific Islander" ///
        5.race_cat "Other" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to 2015-2025.", ///
        "Treatment group excludes Missouri and North Dakota.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: Alternative Treatment Group and Labor Force Participation")

restore



* Table 4: Employment outcome

eststo clear

eststo m1: regress employed i.treatment##i.post, vce(robust)
eststo m2: regress employed i.treatment##i.post, vce(cluster statefip)
eststo m3: regress employed i.treatment##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress employed i.treatment##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_Employment.rtf", replace ///
    keep(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treatment "Treatment" ///
        1.post "Post" ///
        1.treatment#1.post "Treatment x Post" ///
        age "Age" ///
        2.race_cat "Black" ///
        3.race_cat "Native American" ///
        4.race_cat "Asian or Pacific Islander" ///
        5.race_cat "Other" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to 2015-2025.", ///
        "Outcome variable: Employed.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: Employment")

	
	
* Table 5: Ages 18-24

preserve
keep if inrange(age, 18, 24)

eststo clear

eststo m1: regress in_lf i.treatment##i.post, vce(robust)
eststo m2: regress in_lf i.treatment##i.post, vce(cluster statefip)
eststo m3: regress in_lf i.treatment##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress in_lf i.treatment##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_Age18_24_InLF.rtf", replace ///
    keep(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treatment "Treatment" ///
        1.post "Post" ///
        1.treatment#1.post "Treatment x Post" ///
        age "Age" ///
        2.race_cat "Black" ///
        3.race_cat "Native American" ///
        4.race_cat "Asian or Pacific Islander" ///
        5.race_cat "Other" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to women ages 18-24, 2015-2025.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: Ages 18-24 and Labor Force Participation")

restore



* Table 6: Ages 25-44

preserve
keep if inrange(age, 25, 44)

eststo clear

eststo m1: regress in_lf i.treatment##i.post, vce(robust)
eststo m2: regress in_lf i.treatment##i.post, vce(cluster statefip)
eststo m3: regress in_lf i.treatment##i.post i.statefip i.year, vce(cluster statefip)
eststo m4: regress in_lf i.treatment##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "Robustness_Age25_44_InLF.rtf", replace ///
    keep(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(1.treatment 1.post 1.treatment#1.post age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        1.treatment "Treatment" ///
        1.post "Post" ///
        1.treatment#1.post "Treatment x Post" ///
        age "Age" ///
        2.race_cat "Black" ///
        3.race_cat "Native American" ///
        4.race_cat "Asian or Pacific Islander" ///
        5.race_cat "Other" ///
        2.educ_cat "High School" ///
        3.educ_cat "Less Than College" ///
        4.educ_cat "Bachelor's Degree" ///
        5.educ_cat "Graduate Degree" ///
        married "Married" ///
        nchild "Number of Children in Household" ///
        nchlt5 "Number of Children Under 5 in Household" ///
        in_poverty "Below Poverty Line" ///
    ) ///
    cells("b(star fmt(3)) se(par fmt(3))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to women ages 25-44, 2015-2025.", ///
        "Column (1) uses robust standard errors.", ///
        "Columns (2)-(4) cluster standard errors at the state level.", ///
        "Column (3) adds state and year fixed effects.", ///
        "Column (4) adds demographic controls plus state and year fixed effects.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Robustness Check: Ages 25-44 and Labor Force Participation")

restore
