// Jameson Colbert, Data Mgmt, PS2, 17 Feb 2021
// Dr. Adam Okulicz-Kozaryn
// MERGING

cd C:\Users\jhc157

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes COVID Data
desc
tab date
desc
tab state
keep if state == "New Jersey"
desc
tab state

insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
keep if state == "New Jersey"
// save as .dta in the code!!

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data
keep if stname == "New Jersey"

tab stname
tab ctyname

merge 1:1 _n using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
list //could not work, STATA gave an error message stating this above .csv is not a stata format
clear

merge 1:1 _n using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data

//ended up saving both datasets as .dta files with only NJ data

clear
use C:\Users\jhc157\Documents\nytimescovid.dta
tab state

use nytimescovid.dta, clear // master?
keep state
use censusNJdata.dta, clear // using?
keep stname 
merge 1:1 _n using censusNJdata.dta 
// merge on state in the future, not on _n can be arbitrary and produce mistakes
tab _merge // not matched: 0 matched: 22

desc _merge

//Encoding a string variable

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
generate var americanstate = state
// do not include var
replace var state = americanstate
tab americanstate

//above method didn't work! I suspected it might be because state is a string, so i tried below method

encode state, generate(americanstate)
tab americanstate //great it worked!

//Recoding
clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
keep if state == "Delaware"
tab county
tab cases //47,349 cases most recently
recode cases (0/47349 = 1), gen(newcase)
tab newcase

//insheet only once
// explain project goals 
// add more commands like bys:gen etc before next week
