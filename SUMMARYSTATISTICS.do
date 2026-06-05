* Summary Statistics Table

capture which esttab
if _rc ssc install estout

preserve

* Pre-Treatment Period
keep if post == 0

* Binary Variables as Percentages
capture drop married_pct
gen married_pct = 100*married
label variable married_pct "Married (%)"

capture drop in_poverty_pct
gen in_poverty_pct = 100*in_poverty
label variable in_poverty_pct "Below Poverty Line (%)"

capture drop employed_pct
gen employed_pct = 100*employed
label variable employed_pct "Employed (%)"

capture drop in_lf_pct
gen in_lf_pct = 100*in_lf
label variable in_lf_pct "In the Labor Force (%)"

* Race %
forvalues i = 1/5 {
    capture drop race_`i'_pct
    gen race_`i'_pct = 100*(race_cat == `i') if race_cat < .
}

label variable race_1_pct "   White"
label variable race_2_pct "   Black"
label variable race_3_pct "   Native American"
label variable race_4_pct "   Asian or Pacific Islander"
label variable race_5_pct "   Other"

* Education %
forvalues i = 1/5 {
    capture drop educ_`i'_pct
    gen educ_`i'_pct = 100*(educ_cat == `i') if educ_cat < .
}

label variable educ_1_pct "   Less Than High School"
label variable educ_2_pct "   High School"
label variable educ_3_pct "   Less Than College"
label variable educ_4_pct "   Bachelor's Degree"
label variable educ_5_pct "   Graduate Degree"

* Table Variables
local tablevars ///
    age ///
    race_1_pct race_2_pct race_3_pct race_4_pct race_5_pct ///
    educ_1_pct educ_2_pct educ_3_pct educ_4_pct educ_5_pct ///
    married_pct ///
    nchild ///
    nchlt5 ///
    in_poverty_pct ///
    employed_pct ///
    in_lf_pct

* Create Table
estpost ttest `tablevars', by(treatment)

esttab using "BaselineSummary_PreTreatment.rtf", replace ///
    cells("mu_1(fmt(2)) mu_2(fmt(2)) b(fmt(2)) p(fmt(3))") ///
    collabels("Control" "Treatment" "Difference" "p-value") ///
    label nonumber nomtitle ///
    refcat(race_1_pct "Race (%)" educ_1_pct "Education (%)", nolabel) ///
    title("Baseline Summary Statistics (Pre-Treatment Period)") ///
    addnotes("Pre-treatment period defined as post = 0.", ///
             "Binary and categorical variables are reported as percentages.")

restore
