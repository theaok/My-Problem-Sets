// Jameson Colbert, Data Mgmt, PS2, 17 Feb 2021
// Dr. Adam Okulicz-Kozaryn
// MERGING

//again put commnt what this research is about

insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes COVID Data

//could interpret if see anything interesting from descriptive stats
desc
tab date
desc
tab state
keep if state == "New Jersey"
desc
tab state
//and should save it! vhats the point of manipulating and fixing it if you you don't save it

insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
keep if state == "New Jersey"

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data
keep if stname == "New Jersey"
//same here should save

tab stname
tab ctyname

//and then merge with saved one
merge 1:1 _n using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
list
clear

//same here
merge 1:1 _n using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data

//yeah exactly, should just do it
//ended up saving both datasets as .dta files with only NJ data

clear //again dont use paths
use C:\Users\jhc157\Documents\nytimescovid.dta
tab state

use nytimescovid.dta, clear // master?
keep state
use censusNJdata.dta, clear // using?//! no using is une on hard drive
keep stname 
merge 1:1 _n using censusNJdata.dta  //so here you merged same dataset with same dataset!
tab _merge // not matched: 0 matched: 22

desc _merge

//Encoding a string variable

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
generate var americanstate = state //drop var
replace var state = americanstate
tab americanstate

//above method didn't work! I suspected it might be because state is a string, so i tried below method

encode state, generate(americanstate) //its very similar variable, why would you do this?
tab americanstate //great it worked!

//Recoding
clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
keep if state == "Delaware"
tab county
tab cases //47,349 cases most recently
recode cases (0/47349 = 1), gen(newcase) //again it should make not just technical but substantive sense
tab newcase
