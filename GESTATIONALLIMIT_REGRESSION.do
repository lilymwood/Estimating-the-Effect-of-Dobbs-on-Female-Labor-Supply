* Gestational Limit Regression Table
* Outcome: In the Labor Force

cd "/Users/lilywood/Documents/Honors Thesis (Final)"

do "/Users/lilywood/Documents/Honors Thesis (Final)/SETUP.do"

capture which esttab
if _rc ssc install estout

keep if inrange(year, 2015, 2025)

* Rescale Coefficient
capture drop gl_restrict
gen gl_restrict = 24 - gl if gl < .
label variable gl_restrict "Abortion Restrictiveness (24 - Gestational Limit)"

* Express Restrictiveness in 6-week Increments
capture drop gl_restrict6
gen gl_restrict6 = gl_restrict/6 if gl_restrict < .
label variable gl_restrict6 "Abortion Restrictiveness (6-Week Increments)"

eststo clear

* Continuous Policy Measure
eststo m1: regress in_lf gl_restrict6, vce(cluster statefip)

* Demographic Controls
eststo m2: regress in_lf gl_restrict6 ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty, ///
    vce(cluster statefip)

* State and Year Fixed Effects
eststo m3: regress in_lf gl_restrict6 i.statefip i.year, vce(cluster statefip)

* Preferred Specification: Controls + State & Year FE
eststo m4: regress in_lf gl_restrict6 ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip i.year, vce(cluster statefip)

esttab m1 m2 m3 m4 using "RegressionResults_GestationalLimit.rtf", replace ///
    keep(gl_restrict6 age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
         2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    order(gl_restrict6 age 2.race_cat 3.race_cat 4.race_cat 5.race_cat ///
          2.educ_cat 3.educ_cat 4.educ_cat 5.educ_cat married nchild nchlt5 in_poverty) ///
    coeflabels( ///
        gl_restrict6 "Abortion Restrictiveness (6-Week Increments)" ///
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
    cells("b(star fmt(5)) se(par fmt(5))") ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    nonumber ///
    mtitles("(1)" "(2)" "(3)" "(4)") ///
    stats(N r2, fmt(0 3) labels("Observations" "R-squared")) ///
    addnotes( ///
        "Sample restricted to women ages 15-44, 2015-2025.", ///
        "Gestational limit is capped at 24 weeks; higher values imply less restrictive abortion policy.", ///
        "The regressor is rescaled as (24 minus gestational limit) divided by 6, so larger values indicate tighter restrictions in 6-week increments.", ///
        "Columns (3) and (4) include state and year fixed effects.", ///
        "Columns (2) and (4) add demographic controls.", ///
        "Standard errors clustered at the state level.", ///
        "Omitted race category: White. Omitted education category: Less Than High School." ///
    ) ///
    title("Gestational Limit and Female Labor Force Participation")
