* Difference-in-Differences Regression Table
* Outcome: In the Labor Force

cd "/Users/lilywood/Documents/Honors Thesis (Final)"

do "/Users/lilywood/Documents/Honors Thesis (Final)/SETUP.do"

capture which esttab
if _rc ssc install estout

eststo clear

* Baseline DID with Robust Standard Errors
eststo m1: regress in_lf i.treatment##i.post, vce(robust)

* Baseline DID with Clustered Standard Errors
eststo m2: regress in_lf i.treatment##i.post, vce(cluster statefip)

* DID with State and Year Fixed Effects
eststo m3: regress in_lf i.treatment##i.post i.statefip i.year, vce(cluster statefip)

* DID with Fixed Effects and Baseline Covariates
eststo m4: regress in_lf i.treatment##i.post ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "RegressionResults_InLF.rtf", replace ///
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
    label ///
    nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Outcome variable: In the Labor Force.", ///
        "Column (1) includes the basic difference-in-differences specification with robust standard errors.", ///
        "Column (2) reports the same baseline specification with standard errors clustered at the state level.", ///
        "Column (3) adds state and year fixed effects with standard errors clustered at the state level.", ///
        "Column (4) adds demographic controls plus state and year fixed effects with standard errors clustered at the state level.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Difference-in-Differences Estimates: Labor Force Participation")
