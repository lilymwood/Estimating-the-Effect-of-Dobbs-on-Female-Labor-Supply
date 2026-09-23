* Create GestationalLimit.dta

cd "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map"

import excel "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/GestationalLimits.xlsx", sheet("Gestational Limits") firstrow clear

rename D gl2010
rename E gl2011
rename F gl2012
rename G gl2013
rename H gl2014
rename I gl2015
rename J gl2016
rename K gl2017
rename L gl2018
rename M gl2019
rename N gl2020
rename O gl2021
rename P gl2022
rename Q gl2023
rename R gl2024
rename S gl2025

rename GestationalLimit glcurrent

label variable gl2010 "Gestational Limit 2010"
label variable gl2011 "Gestational Limit 2011"
label variable gl2012 "Gestational Limit 2012"
label variable gl2013 "Gestational Limit 2013"
label variable gl2014 "Gestational Limit 2014"
label variable gl2015 "Gestational Limit 2015"
label variable gl2016 "Gestational Limit 2016"
label variable gl2017 "Gestational Limit 2017"
label variable gl2018 "Gestational Limit 2018"
label variable gl2019 "Gestational Limit 2019"
label variable gl2020 "Gestational Limit 2020"
label variable gl2021 "Gestational Limit 2021"
label variable gl2022 "Gestational Limit 2022"
label variable gl2023 "Gestational Limit 2023"
label variable gl2024 "Gestational Limit 2024"
label variable gl2025 "Gestational Limit 2025"

label variable glcurrent "Gestational Limit"

save "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/GestationalLimit.dta", replace

** MAP

* Merge Map Data w/ GestationalLimit.dta

cd "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/cb_2018_us_state_500k"

shp2dta using cb_2018_us_state_500k.shp, ///
    database(us_states) ///
    coordinates(us_states_coord) ///
    genid(id) ///
    replace

use us_states, clear
describe

merge 1:1 NAME using "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/MapGestationalLimit.dta"
drop if inlist(NAME, "Alaska", "American Samoa", "Commonwealth of the Northern Mariana Islands", "Guam", "Hawaii", "Puerto Rico", "United States Virgin Islands")

* Current Gestational Limits Choropleth Map

colorpalette blues, n(6) nograph
local cols `r(p)'

format glcurrent %12.1f
spmap glcurrent using us_states_coord, id(id) ///
    fcolor("`cols'") ///
    clmethod(unique) ///
    ocolor(gs12 ..) osize(vthin ..) ///
    title("Gestational Limits in Weeks (As of March 2026)") ///
    legend(title("Weeks"))
	
* Treatment & Control Map

gen treatment = inlist(STATEFIP,1,5,16,21,22,28,29,38,40,46,47,48,54)

spmap treatment using us_states_coord, id(id) ///
    fcolor("239 243 255" "8 81 156") ///
    clmethod(unique) ///
    ocolor(gs12 ..) osize(vthin ..) ///
    title("States in Treatment and Control Groups") ///
    legend(title("Group"))
