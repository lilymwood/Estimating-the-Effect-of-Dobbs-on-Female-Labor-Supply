* Event Study: Female Labor Force Participation

cd "/Users/lilywood/Documents/Honors Thesis (Final)"

do "/Users/lilywood/Documents/Honors Thesis (Final)/SETUP.do"

capture which coefplot
if _rc ssc install coefplot

keep if inrange(year, 2015, 2025)

* Event Study

regress in_lf ib2019.year##i.treatment ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip, vce(cluster statefip)
estimates store event_2019

coefplot event_2019, ///
    keep(2015.year#1.treatment 2016.year#1.treatment 2017.year#1.treatment ///
         2018.year#1.treatment 2020.year#1.treatment 2021.year#1.treatment ///
         2022.year#1.treatment 2023.year#1.treatment 2024.year#1.treatment ///
         2025.year#1.treatment) ///
    coeflabels( ///
         2015.year#1.treatment = "2015" ///
         2016.year#1.treatment = "2016" ///
         2017.year#1.treatment = "2017" ///
         2018.year#1.treatment = "2018" ///
         2020.year#1.treatment = "2020" ///
         2021.year#1.treatment = "2021" ///
         2022.year#1.treatment = "2022" ///
         2023.year#1.treatment = "2023" ///
         2024.year#1.treatment = "2024" ///
         2025.year#1.treatment = "2025") ///
    vertical ///
    yline(0, lpattern(dash) lcolor(black)) ///
    xline(7.5, lpattern(dash) lcolor(gs8)) ///
    ciopts(recast(rcap) lcolor(black)) ///
    msymbol(O) ///
    mcolor(black) ///
    mfcolor(white) ///
    xlabel(, angle(0) labsize(medsmall)) ///
    ylabel(, format(%4.2f) labsize(medsmall)) ///
    title("Event Study: Female Labor Force Participation", size(large)) ///
    subtitle("Reference Year = 2019", size(medsmall)) ///
    ytitle("Coefficient Relative to 2019", size(medium)) ///
    xtitle("Survey Year", size(medium)) ///
    graphregion(color(white)) ///
    plotregion(color(white)) ///
    bgcolor(white) ///
    legend(off) ///
    name(event_2019_plot, replace)

graph save "EventStudy_InLF_Ref2019.gph", replace

regress in_lf ib2022.year##i.treatment ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip, vce(cluster statefip)
estimates store event_2022

coefplot event_2022, ///
    keep(2015.year#1.treatment 2016.year#1.treatment 2017.year#1.treatment ///
         2018.year#1.treatment 2019.year#1.treatment 2020.year#1.treatment ///
         2021.year#1.treatment 2023.year#1.treatment 2024.year#1.treatment ///
         2025.year#1.treatment) ///
    coeflabels( ///
         2015.year#1.treatment = "2015" ///
         2016.year#1.treatment = "2016" ///
         2017.year#1.treatment = "2017" ///
         2018.year#1.treatment = "2018" ///
         2019.year#1.treatment = "2019" ///
         2020.year#1.treatment = "2020" ///
         2021.year#1.treatment = "2021" ///
         2023.year#1.treatment = "2023" ///
         2024.year#1.treatment = "2024" ///
         2025.year#1.treatment = "2025") ///
    vertical ///
    yline(0, lpattern(dash) lcolor(black)) ///
    xline(7.5, lpattern(dash) lcolor(gs8)) ///
    ciopts(recast(rcap) lcolor(black)) ///
    msymbol(O) ///
    mcolor(black) ///
    mfcolor(white) ///
    xlabel(, angle(0) labsize(medsmall)) ///
    ylabel(, format(%4.2f) labsize(medsmall)) ///
    title("Event Study: Female Labor Force Participation", size(large)) ///
    subtitle("Reference Year = 2022", size(medsmall)) ///
    ytitle("Coefficient Relative to 2022", size(medium)) ///
    xtitle("Survey Year", size(medium)) ///
    graphregion(color(white)) ///
    plotregion(color(white)) ///
    bgcolor(white) ///
    legend(off) ///
    name(event_2022_plot, replace)

graph save "EventStudy_InLF_Ref2022.gph", replace

regress in_lf ib2021.year##i.treatment ///
    age i.race_cat i.educ_cat married nchild nchlt5 in_poverty ///
    i.statefip, vce(cluster statefip)
estimates store event_2021

coefplot event_2021, ///
    keep(2015.year#1.treatment 2016.year#1.treatment 2017.year#1.treatment ///
         2018.year#1.treatment 2019.year#1.treatment 2020.year#1.treatment ///
         2022.year#1.treatment 2023.year#1.treatment 2024.year#1.treatment ///
         2025.year#1.treatment) ///
    coeflabels( ///
         2015.year#1.treatment = "2015" ///
         2016.year#1.treatment = "2016" ///
         2017.year#1.treatment = "2017" ///
         2018.year#1.treatment = "2018" ///
         2019.year#1.treatment = "2019" ///
         2020.year#1.treatment = "2020" ///
         2022.year#1.treatment = "2022" ///
         2023.year#1.treatment = "2023" ///
         2024.year#1.treatment = "2024" ///
         2025.year#1.treatment = "2025") ///
    vertical ///
    yline(0, lpattern(dash) lcolor(black)) ///
    xline(7.5, lpattern(dash) lcolor(gs8)) ///
    ciopts(recast(rcap) lcolor(black)) ///
    msymbol(O) ///
    mcolor(black) ///
    mfcolor(white) ///
    xlabel(, angle(0) labsize(medsmall)) ///
    ylabel(, format(%4.2f) labsize(medsmall)) ///
    title("Event Study: Female Labor Force Participation", size(large)) ///
    subtitle("Reference Year = 2021", size(medsmall)) ///
    ytitle("Coefficient Relative to 2021", size(medium)) ///
    xtitle("Survey Year", size(medium)) ///
    graphregion(color(white)) ///
    plotregion(color(white)) ///
    bgcolor(white) ///
    legend(off) ///
    name(event_2021_plot, replace)

graph save "EventStudy_InLF_Ref2021.gph", replace
