// Jameson Colbert, Data Mgmt, PS3, 24 February 2021
// Dr. Adam Okulicz-Kozaryn

/* For this problem set, I merged COVID data with NJ census data, NJ poverty data 
(both raw poverty numbers and percentages), NJ unemployment data, data on contaminated 
sites in NJ counties, and rates of 
uninsurance. My hypothesis would be that counties with greater poverty rates and signs
of socioeconomic distress (unemployment and lack of health insurance)
would see higher mean deaths/cases from COVID. After the merge, I am noticing some 
correlation between poverty rates and pandemic deaths, however this can be attr-
ibuted to population and population density. An example would be Bergen County,
a wealthy suburb of New York with low poverty rate but high mean cases and 
deaths from COVID. It is New Jersey's most populated county with nearly 1 million
residents. Another example is Cumberland county, one of NJ's poorest but least 
populated counties. It has a low mean case and death rate.
Future research should include population density numbers by county as
well as information on health rankings by county.

Reshape was difficult.
*/

cd C:\Users\jhc157

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes COVID Data
keep if state == "New Jersey"
replace county = "Atlantic County" if county == "Atlantic"
replace county = "Bergen County" if county == "Bergen"
replace county = "Burlington County" if county == "Burlington"
replace county = "Camden County" if county == "Camden"
replace county = "Cape May County" if county == "Cape May"
replace county = "Cumberland County" if county == "Cumberland"
replace county = "Essex County" if county == "Essex"
replace county = "Gloucester County" if county == "Gloucester"
replace county = "Hudson County" if county == "Hudson"
replace county = "Hunterdon County" if county == "Hunterdon"
replace county = "Mercer County" if county == "Mercer"
replace county = "Middlesex County" if county == "Middlesex"
replace county = "Monmouth County" if county == "Monmouth"
replace county = "Morris County" if county == "Morris"
replace county = "Ocean County" if county == "Ocean"
replace county = "Passaic County" if county == "Passaic"
replace county = "Salem County" if county == "Salem"
replace county = "Somerset County" if county == "Somerset"
replace county = "Sussex County" if county == "Sussex"
replace county = "Union County" if county == "Union"
replace county = "Warren County" if county == "Warren"
collapse cases deaths, by(county)
keep if county == "Atlantic County" | county == "Bergen County" | county == "Burlington County" | county == "Camden County" | county == "Cape May County" | county == "Cumberland County" | county == "Essex County" | county == "Gloucester County" | county == "Hudson County" | county == "Hunterdon County" | county == "Mercer County" | county == "Middlesex County" | county == "Monmouth County" | county == "Morris County" | county == "Ocean County" | county == "Passaic County" | county == "Salem County" | county == "Somerset County" | county == "Sussex County" | county == "Union County" | county == "Warren County"
l
save NJCovidCasesAndDeathsByCountyB.dta
// data sourced the NYTimes Github

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata_CLEANED_UP_2.csv //Census data
keep if stname == "New Jersey"
l
save NJCensusPop2019B.dta
// data sourced from US Census

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/NJpoverty2019B.csv
save NJPoverty2019.dta
// NJ poverty data. data sourced from US Census

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/NJPercBelowPov2019.csv
save NJPovertyPerc2019.dta
// NJ poverty data, percent of those under poverty line. data sourced from US Census (same as above)

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/2020countyhealthuninsuredRWJ.csv
drop uninsurednumber
save NJUninsuredPercent.dta
// Rates of uninsured persons. data sourced from https://www.countyhealthrankings.org/app/new-jersey/2020/overview

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/NJActiveContamSites2020.csv
save NJContamSites.dta
// Data on contaminated sites in NJ by county. data sourced from https://www.state.nj.us/dep/srp/kcsnj/ 

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/USDAunemp%26medianhouseholdinc_NJ2019.csv
drop civilian_labor_force_2019
drop employed_2019
drop unemployed_2019
drop median_household_income_2019
drop med_hh_income_percent_of_state_t
l
save NJUnemployment2019.dta
// data on unemployment. data sourced from https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/ 

clear
use C:\Users\jhc157\NJCovidCasesAndDeathsByCountyB.dta
desc
use NJCensusPop2019B.dta, clear // master
desc
drop county
rename ctyname county
drop state 
rename stname state 
merge 1:m county using NJCovidCasesAndDeathsByCountyB.dta 
drop _merge
merge m:1 county using NJBelowPov.dta
drop _merge
merge m:1 county using NJPovertyPerc2019.dta
drop _merge
merge m:1 county using NJUninsuredPercent.dta
drop _merge
merge m:1 county using NJUnemployment2019
drop _merge
merge m:1 county using NJContamSites.dta 
tab _merge
tab county
desc _merge
l

drop _merge
drop state
help reshape
reshape wide cases, i(census2010pop) j(popestimate2019) //reshape giving me lots of trouble. Not very sensible!
reshape long

clear
// merge again
reshape wide activesiteswithconfirmedcontamin, i(census2010pop) j(popestimate2019)
