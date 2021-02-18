// Jameson Colbert, Data Mgmt, PS2, 17 Feb 2021: Updated 18 Feb 2021
// Dr. Adam Okulicz-Kozaryn
// MERGING

/* For this problem set, I merged COVID data with NJ census data, in an effort to see how NJ looked when it came to COVID. 
The merging was successful and allowed me to look at NJ county COVID data along with population numbers. Will be useful for my later PS, such as those including poverty numbers. 
Also ran generating, encoding, recoding, replacing, collapsing, drop, bys, and egen */

cd C:\Users\jhc157

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes COVID Data
keep if state == "New Jersey"
save uscounties.dta

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data
keep if stname == "New Jersey"
save NJcensus.dta 

clear
use C:\Users\jhc157\uscounties.dta
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
desc
use NJcensus.dta, clear // master
desc
drop county
rename ctyname county
drop state 
rename stname state 
merge 1:m county using uscounties.dta 
tab _merge // not matched: 0 matched: 22  

desc _merge
l

//Encoding a string variable
clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
encode state, generate(americanstate)
tab americanstate //great it worked!

//DROP
// only using the northeast. for use in future PS where i might only want to look at Jersey within the northeast rather than the whole country.
clear
drop if state == "Guam"
keep if state == "New Jersey" | state == "New York" | state == "Pennsylvania" | state == "Connecticut" | state == "Rhode Island" | state == "Massachusetts" | state == "Vermont" | state == "New Hampshire" | state == "Maine"
tab state //yay

//Recoding
keep if state == "Delaware"
save delcounties.dta
tab county
tab cases //47,349 cases most recently
recode cases (0/47349 = 1), gen(newcase)
tab newcase

//Recoding Again
keep if state == "Delaware"
recode cases (0/25000 = 1)(25000/47349 = 2), gen(casesrecoded)
tab casesrecoded

//Collapse
collapse (mean) cases deaths, by(state)
list //provides the mean number of cases and deaths per state

//Bys and egen
keep if state == "Maryland"
bys date: egen avg_deaths=mean(deaths)
sum avg_deaths
l

//Gen and Replace
use C:\Users\jhc157\uscounties.dta
gen northjersey =. 
gen southjersey =.
replace northjersey=1 if county == "Essex" | county == "Bergen" | county == "Hudson" | county == "Union" | county == "Warren" | county == "Middlesex" | county == "Sussex" | county == "Passaic" | county == "Morris" | county == "Somerset" | county == "Hunterdon" | county == "Mercer"
replace northjersey=0 if county == "Burlington" | county == "Ocean" | county == "Monmouth" | county == "Cape May" | county == "Camden" | county == "Cumberland" | county == "Salem" | county == "Gloucester" | county == "Atlantic"
