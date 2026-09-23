* Create Map Version of AbortionIncidence.dta

cd "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map"

import excel "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/AbortionIncidence.xlsx", sheet("Abortion Incidence") firstrow clear

rename STATE NAME

rename C ai1988
rename D ai1992
rename E ai1996
rename F ai2000
rename G ai2005
rename H ai2006
rename I ai2007
rename J ai2008
rename K ai2009
rename L ai2010
rename M ai2011
rename N ai2012
rename O ai2013
rename P ai2014
rename Q ai2015
rename R ai2016
rename S ai2017
rename T ai2018
rename U ai2019
rename V ai2020
rename W aiaverage

label variable ai1988 "Abortion Incidence 1988"
label variable ai1992 "Abortion Incidence 1992"
label variable ai1996 "Abortion Incidence 1996"
label variable ai2000 "Abortion Incidence 2000"
label variable ai2005 "Abortion Incidence 2005"
label variable ai2006 "Abortion Incidence 2006"
label variable ai2007 "Abortion Incidence 2007"
label variable ai2008 "Abortion Incidence 2008"
label variable ai2009 "Abortion Incidence 2009"
label variable ai2010 "Abortion Incidence 2010"
label variable ai2011 "Abortion Incidence 2011"
label variable ai2012 "Abortion Incidence 2012"
label variable ai2013 "Abortion Incidence 2013"
label variable ai2014 "Abortion Incidence 2014"
label variable ai2015 "Abortion Incidence 2015"
label variable ai2016 "Abortion Incidence 2016"
label variable ai2017 "Abortion Incidence 2017"
label variable ai2018 "Abortion Incidence 2018"
label variable ai2019 "Abortion Incidence 2019"
label variable ai2020 "Abortion Incidence 2020"
label variable aiaverage "Average Abortion Incidence 2010-2020"

save "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/MapAbortionIncidence.dta", replace

* Merge Map Data w/ AbortionIncidence.dta

cd "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/cb_2018_us_state_500k"

shp2dta using cb_2018_us_state_500k.shp, ///
    database(us_states) ///
    coordinates(us_states_coord) ///
    genid(id) ///
    replace

use us_states, clear
describe

merge 1:1 NAME using "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/MapAbortionIncidence.dta"
drop if inlist(NAME, "Alaska", "American Samoa", "Commonwealth of the Northern Mariana Islands", "Guam", "Hawaii", "Puerto Rico", "United States Virgin Islands")

* Average Abortion Incidence 2010-2020 Choropleth Map

colorpalette blues, n(6) nograph
local cols `r(p)'

format aiaverage %12.1f
spmap aiaverage using us_states_coord, id(id) ///
    fcolor("`cols'") ///
    clmethod(quantile) clnumber(6) ///
    ocolor(gs12 ..) osize(vthin ..) ///
    title("Average Abortion Incidence 2010-2020") ///
    legend(title("Average Incidence"))

* Average Abortion Incidence 2010-2020 Bubble Map

cd "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/cb_2018_us_state_500k"

shp2dta using cb_2018_us_state_500k.shp, ///
    database(us_states) ///
    coordinates(us_states_coord) ///
    genid(id) ///
    replace

use us_states_coord, clear
collapse (mean) _X _Y, by(_ID)
rename _ID id
rename _X lon
rename _Y lat
save state_centers, replace

use us_states, clear

merge 1:1 NAME using "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/MapAbortionIncidence.dta"
drop _merge

drop if inlist(NAME, "Alaska", "American Samoa", ///
    "Commonwealth of the Northern Mariana Islands", ///
    "Guam", "Hawaii", "Puerto Rico", ///
    "United States Virgin Islands")

merge 1:1 id using state_centers
drop if _merge == 2
drop _merge

gen ai_size = aiaverage^2

save state_map_data, replace

spmap using us_states_coord, id(id) ///
    fcolor(white) ///
    ocolor(gs14 ..) osize(vthin ..) ///
    point(data(state_map_data) xcoord(lon) ycoord(lat) ///
          proportional(ai_size) ///
          size(*1.2) ///
          fcolor(eltblue*0.4) ///
          ocolor(navy) ///
          osize(vthin)) ///
    title("Average Abortion Incidence 2010-2020")

** SCATTER PLOT

* Merge Abortion Incidence & Gestational Limit Data

cd "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map"

use MapAbortionIncidence.dta, clear

merge 1:1 STATEFIP using "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/GestationalLimit.dta"

* Create Scatter Plot

twoway scatter aiaverage glcurrent, ///
    msymbol(O) ///
    msize(vlarge) ///
    mcolor(navy%50) ///
    mlabel(Code) ///
    mlabcolor(white) ///
    mlabsize(tiny) ///
    mlabposition(0) ///
    xtitle("Gestational Limit (weeks)") ///
    ytitle("Average Abortion Incidence (2010-2020)") ///
	title("Pre-Dobbs Abortion Incidence by Current Gestational Limit")
    graphregion(color(white))
