// Jameson Colbert
// Data Management
// Dr. Adam Okulicz-Kozaryn
// 3 Feb 2021
// Just redoing PS1 now that I have a better grasp on the software. Considering 
// buying it since using thru the virtual library is a bit of a headache
// but I'm analyzing 2018 GSS data and am getting the hang of it, but it will
// take quite a while I think.


use https://https://sites.google.com/a/scarletmail.rutgers.edu/jamesondatman/files/GSS2018.dta, clear
// was not successful "host not found"
// will try importing from a website or google doc another time
// will try uploading from unzipped file
use "C:\Users\jhc157.RAD.000\Downloads\GSS2018.dta"

cd C:\Users\jhc157.RAD.000\Documents

sum abpoor
sum abpoor, detail

tab income
l // produced a LOT of data, will maybe only do a subset of data, there are ~2k obs

clear
use "C:\Users\jhc157.RAD.000\Downloads\GSS2018.dta"
cd C:\Users\jhc157.RAD.000\Documents

sum class //4 classes
sum class, detail
d class
d class, detail
l

save C:\Users\jhc157.RAD.000\Documents\GSS2018B.dta
save C:\Users\jhc157.RAD.000\Documents\GSS2018B.txt
save C:\Users\jhc157.RAD.000\Documents\GSS2018B.html

save C:\Users\jhc157.RAD.000\Documents\GSS2018B2.dta
save C:\Users\jhc157.RAD.000\Documents\GSS2018C.txt
save C:\Users\jhc157.RAD.000\Documents\GSS2018D.html

count //2348 obs, too much
sample 25 //25% of obs, 1761 obs deleted

tab class //gave information on what each of the 4 classes is called (working class, upper class etc)
l // still a lot of info

count //~583 obs
sample 50

sum class, detail // will be trying to get a look at a subset of class, like working class

sum sex // min is 1, max is 2
d sex
tab sex (bible) // we get to see different opinions of the bible divided by sex

tab bible //word of god vs inspired word vs book of fables vs other

tab sex (bible) // lets do this again and see what we got
// so it seems women are more likely to see it as the word of god (women 57, men 30)
// or an inspired book (women 85, men 57), 
//while men are more likely to see it as a book of fables (women 12, men 35)
// however, very small sample, maybe we can clear it and go from the larger ~2k obs

clear 
use C:\Users\jhc157.RAD.000\Documents\GSS2018B.dta

tab sex (bible)
// similar results, women seem to be much more of the opinion that the bible
// is the word of god (438 vs. 268 for men) and inspired book (607 vs 472)

//let's analyze by class?
tab class (bible)
// the working and middle classes have the most overall representation,
// so while it seems they are the most likely to believe the bible is the word
// of god (326 working class believe so vs only 93 of the lower class) we
// must consider proportion
// 93 lower class believe bible is word of god (WoG). there are 208 total lower
// class obsvs. 93 div by 208 is roughly .45
// 326 working class believe bible is WoG. there are 1,010 total working class
// obsvs. 326 div by 1,010 is roughly .33.
// thus, a higher proportion of the lower class believes that the bible is god's
// word.

tab age (bible) //each year is given from age 18 to 88, could maybe group discrete
// age groups into brackets, not sure if I know how to do that yet

sum age
d age, detail

count

tab cat // does not have cat vs has cat
tab sex (cat)
tab class (cat)
tab class (dog)//people in general seem to have dogs rather than cats

tab abmoral // 28% of obs are morally opposed to abortion, 27.63% not morally opposed
// while 43.51% say it depends

tab class (abmoral) // the numbers shake out pretty similarly
tab relig (abmoral) // protestants seem very opposed to abortion on a moral basis
// 420 morally opposed; 226 not morally opposed; 465 it depends

tab god // on belief in god
tab relig (god)
tab class (god)

save C:\Users\jhc157.RAD.000\Documents\GSS2018B3.dta
save C:\Users\jhc157.RAD.000\Documents\GSS2018C2.txt
save C:\Users\jhc157.RAD.000\Documents\GSS2018D2.html

// saved dofile as PS1jamesonc
