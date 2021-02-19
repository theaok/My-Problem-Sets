// Jameson Colbert
// Data Management
// Dr. Adam Okulicz-Kozaryn
// 3 Feb 2021; UPDATED: 18 Feb 2021
/* Updating PS1 to reflect your feedback. I used data from census and cleaned
it up in excel before uploading to github and importing here. I played around
with the data before creating a graph and scatter plot */

clear
cd C:\Users\jhc157
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/NJpoverty2019B.csv
save NJpovertyB.dta //saving first as a .dta

use NJpovertyB.dta
tab county
l
tab pop
l
graph hbar pop belowpov, over(county) /*not sure why it says "mean of"
it seems the higher the population, the higher the population of those below the 
poverty line*/

gen cty =.
replace cty=1 if county == "Atlantic County, New Jersey" 
replace cty=2 if county == "Bergen County, New Jersey" 
replace cty=3 if county == "Burlington County, New Jersey" 
replace cty=4 if county == "Camden County, New Jersey" 
replace cty=5 if county == "Cape May County, New Jersey" 
replace cty=6 if county == "Cumberland County, New Jersey" 
replace cty=7 if county == "Essex County, New Jersey" 
replace cty=8 if county == "Gloucester County, New Jersey" 
replace cty=9 if county == "Hudson County, New Jersey" 
replace cty=10 if county == "Hunterdon County, New Jersey" 
replace cty=11 if county == "Mercer County, New Jersey" 
replace cty=12 if county == "Middlesex County, New Jersey" 
replace cty=13 if county == "Monmouth County, New Jersey" 
replace cty=14 if county == "Morris County, New Jersey" 
replace cty=15 if county == "Ocean County, New Jersey" 
replace cty=16 if county == "Passaic County, New Jersey" 
replace cty=17 if county == "Salem County, New Jersey" 
replace cty=18 if county == "Somerset County, New Jersey" 
replace cty=19 if county == "Sussex County, New Jersey" 
replace cty=20 if county == "Union County, New Jersey" 
replace cty=21 if county == "Warren County, New Jersey" 

scatter belowpov pop, mlabel(cty) /*clearly there is a correlation between total 
population with number of those below the poverty line will do this again with 
poverty rates, as that may show something different */

sum belowpov //provides min belowpov (5474) and max (122569)

save NJpovertyB.txt //saving second as a .txt
save NJpovertyB.xlsx //saving third as a .xlsx
outsheet using NJpovertyB.html //saving fourth as a .html ??
