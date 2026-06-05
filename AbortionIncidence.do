* Create AbortionIncidence.dta

cd "/Users/lilywood/Documents/Honors Thesis (Final)"

import excel "/Users/lilywood/Documents/Honors Thesis (Final)/Abortion Incidence Map/AbortionIncidence.xlsx", sheet("Abortion Incidence") firstrow clear

rename STATE state
rename STATEFIP statefip

label variable state "State"
label variable statefip "STATEFIP"

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

reshape long ai, i(statefip) j(year)
label variable year "Year"
label variable ai "Abortion Incidence"

save "/Users/lilywood/Documents/Honors Thesis (Final)/AbortionIncidence.dta", replace
