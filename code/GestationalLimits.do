* Create GestationalLimit.dta

cd "/Users/lilywood/Documents/Honors Thesis (Final)"

import excel "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/GestationalLimits.xlsx", sheet("Gestational Limits") firstrow clear

rename State state
rename STATEFIP statefip

label variable state "State"
label variable statefip "STATEFIP"

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

reshape long gl, i(statefip) j(year)
label variable year "Year"
label variable gl "Gestational Limit"

save "/Users/lilywood/Documents/Honors Thesis (Final)/GestationalLimit.dta", replace
