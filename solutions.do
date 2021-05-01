/*Løsninger til opgaver i "Stata - en praktisk introduktion , 3. udgave"
Numrene refererer til opgavenumrene i bogen
*****************************************************
*********************KAPITEL 2***********************
*****************************************************
1: Åbner data*/
update //a: opdaterer Stata
use "DifferentGoods.dta", clear //e: åbner data

*2: Beskriver alle variable
describe

*3: Kodebog for alle variable
codebook

*4: Slår -more- fra
set more off, permanently 

*5:Kodebog igen
codebook

*11: Kodebog for gst
codebook gst

*12 Describe igen
describe

*13: Noter for alle variable
notes

*14: Kodebog med noter
codebook, notes

*15: Åbner databrowseren
browse

*17: databrowser med country, gdpcap og urban

*19: Sorterer data stigende efter recycle
sort recycle

*20: Frekvensfordeling for elecsystem 
tabulate elecsystem 

*21: Frekvensfordeling for elecsystem inkl missing
tabulate elecsystem, missing

*22: databrowser med landenavne og elecsystem
browse country elecsystem

*23: Frekvensfordeling for elecsystem uden labels
tabulate elecsystem, missing nolabel

*24: Codebook for elecsystem
codebook elecsystem

*25: Frekvensfordeling for tre variable
tab1 eu seaaccess recycle

*26: Inspect for alle variable
inspect

*27: Histogram for recycle
histogram recycle, frequency

*29:
summarize //summarize for alle vriable med standard visning
summarize, detail //summarize med additional statistics

*30: Gentager nogle kommandoer
*a)
inspect
*c) Histogram for organic
histogram organic, frequency
*d) Kodebog
codebook

*31: åbner tom do-file
doedit

*32:
*a) Overfører use- og describe-kommandoen
use "DifferentGoods.dta", clear
describe
*b) Histogram for gdpcap
histogram gdpcap, frequency

*35: Gemmersættet data med navnet DifferentGoodsCh2.dta
save "DifferentGoodsCh2.dta",replace

*37: Åbner hjælpen til codebook
help codebook

*39: Åbner hjælpefilen for summarize
help summarize

*40: Åbner hjælpefilen til codebook (og dialog boksen)
help codebook
db codebook

*****************************************************
*********************KAPITEL 3***********************
*****************************************************

*42: Åbner data fra forrige kapitel
use "DifferentGoodsCh2.dta", clear

*43: Åbner variabelmanageren
varmanage

*44: Tildeler labels til urban og female
label variable urban "Urbanization"
label variable female "Females' share of population"

*45:
*a): Tildeler labels til urban og female
label variable urban "Urbanization"
label variable female "Females' share of population"
*b): Tildeler labels til education
label variable education "Tertiary education (share)"

*46:
*a) Tildeler note til frac
notes frac: Ethnic fractionalization (late 1990s) from Alesina et al. 2003
*b) Tildeler label 
label variable frac "Ethnic fractionalization"
*c) Redigerer noten
notes replace education in 1: Share of population above 25 with a tertiary education (in 2001)

*47: Viser eksisterende value labels
label list

*48: Tilknytter noyesLB til eu
label values eu noyesLB

*49: Opretter random1, random2, text og welfarestate
generate random1 = . //a)
generate random2 = . //a)
generate str text = "" //b)
generate byte welfarestate = . //c)
browse //d)
codebook random1 random2 text welfarestate //d)

*50: Indtastning af tal og tekst
replace random1 = 1.1 in 1
replace random1 = 2.2 in 2
replace random2 = 1.2 in 1
replace random2 = 1.3 in 2
replace text = "test" in 1
replace text = "retest" in 2

*51: Opretter value label med navnet welfareLB
label define welfareLB 1 "Conservative" 2 "Liberal" 3 "Socialdemocratic" //a)
label values welfarestate welfareLB // b) tilknytter labelen til variablen welfarestate
describe welfarestate // c) tjekker med describe 

*52: 
*a): Indtater data
replace welfarestate = 1 in 1
replace welfarestate = 1 in 2
replace welfarestate = 1 in 7
replace welfarestate = 1 in 8
replace welfarestate = 1 in 9
replace welfarestate = 1 in 14
replace welfarestate = 1 in 26
replace welfarestate = 1 in 17
replace welfarestate = 2 in 13
replace welfarestate = 2 in 27
replace welfarestate = 3 in 5
replace welfarestate = 3 in 18
replace welfarestate = 3 in 25
*b) Tildeler varibel-label
label variable welfarestate "Welfare state regime"
*c): Tildeler note	
notes welfarestate: Data are entered 28.04.2021. Source: Esping-Andersen, The three world of welfare capitalism, 1990. 

*53: sletter variable
drop random1 random2 text

*54: summarize for gst, git, pm4 og gdpcap ; bestilt med bindestreg
summarize gst-gdpcap 

*55: 
*a) Gemmer datasættet med et nyt navn
save "DifferentGoodsCh3.dta",replace
*b) Sletter observationer, der ikke er kategoriseret som socialdemokratiske
drop if welfarestate !=3
*d) Finder BNP pr indbygger
summarize gdpcap
*e) Åbner det gemte datasæt
use "DifferentGoodsCh3.dta",clear

*56: Finder BNP for socialdemokratiske lande
summarize gdpcap if welfarestate==3

*****************************************************
*********************KAPITEL 4***********************
*****************************************************

*57: Åbner nyt datasæt
use "DanishElectionStudy2005.dta", clear // a+b) åbner data
describe //c) beskriver data 
browse //d) åbner datamatricen

*58: Søger efter oplysninger om køn
lookfor sex gender

*59:
generate gender1 = v312 //a) kopierer v312 til gender1
codebook v312 gender1 //b) kodebog 

*60:
clonevar gender = v312 //a) kopierer med clonevar
codebook v312 gender* //b) kodebog
drop gender1 //c) sletter køn_gen

*61: Flytter gender til starten af datasættet
order gender

*62: Åbner dialogboksen til codebook
db codebook

*63: Dialogboks for recode findes under "Data > Create or change data > Other variable-transformation commands > Recode categorical variable"

*64: Kodebog for variablen gender
codebook gender

*65: 
recode gender (2=0), generate(male) //omkoder gender til male
codebook male //kodebog for male

*66: Krydstabulering mellem gender og male
tabulate gender male

*67:
drop male //a) sletter male
recode gender (1=1 "Male") (2=0 "Female"), generate(male) label(FeMaLB) //b) omkoder og tildeler labels
codebook male //c)

*68:
codebook v314,ta(100) //a) inspicerer kodning
recode v314 (1=1 "Denmark") (2 3 10 = 2 "Western") (nonmissing = 3 "Non-Western"), gen(birthplace) label(birthLB) //a)omkoder og tildeler value labels
label variable birthplace "Country of birth, 3 categories" // c) tildeler variable-labels
tabulate v314 birthplace //d) kontrollerer omkodning

*69:
codebook v20, tabulate (100) // a) inspicerer kodning af v20
recode v20 (1 2 5 7 10 = 0 "Red") (3 4 6 8 9=1 "Blue") (nonmissing=.), generate(blue) label(rbLB) //a) omkoder og tildeler value-label
label variable blue "Red/blue vote" //b)tildeler variabel-label
tabulate blue //c)undersøger stemmefordelingen

*70: Frekvensfordeling for v20
tabulate v20 

*71: Inspicerer partychoice
tabulate partychoice
codebook partychoice, tabulate(100) 

*72:
codebook v351, tabulate (100) //a) viser oplysninger om v351
recode v351 (14 = .a) (15=.b) (16=.c) (17=.d) (18=.e) (19=.f), generate(partychoicetoday) //a)omkoder værdierne 13-19 til missing
label copy V351 PaChToDLB //b) kopierer value-label til PaChToDLB
label values partychoicetoday PaChToDLB //c)tilknytter labelen til variablen
label variable partychoicetoday "Partivalg"

*73:
label define PaChToDLB 1 "Social Democrats" 2 "Social Liberals" 3 "Conservatives" 4 "Centre Democrats" 5 "Socialist People’s Party" ///
6 "Christian Democrats" 7 "Minority Party" 8 "Danish People’s Party" 9 "Liberals" 10 "Leftwing Alliance" ///
11 "Unaffiliated candidate" 13 "Other party" .a "Voted blank" .b "Don’t remember" .c "Decline" .d "Will not vote" ///
.e "Ineligible to vote" .f "Other", replace //a) redigerer value labels
codebook partychoicetoday, tabulate(100) //b) kodebog

*74:
codebook v188 v195 v224 v226 //a) inspicerer variablene med kodebogen
recode v188 v224 v226 (1=5) (2=4) (4=2) (5=1) (8=.), generate (intol1 intol3 intol4) //b) vender disse variable om og sorterer missing fra
recode v195 (8=.), generate(intol2) //b) sorterer missing fra
tab1 intol* //c)inspicerer fordelingerne; det fremgår at v224 om udvisning fremkalder flest intolerante svar

*75:
codebook v137-v144 //inspecerer variablene
recode v137-v144 (1=0) (2=1) (3=.a) (8=.b), prefix(agreeB_) //omkoder til agreeB_v137 osv

*76: Omkoder v357 til en 4 delt variabel inkl. value-labels og variabel-label
recode v357 (65/100 = 4 "65+") (50/65 = 3 "50-64") (30/50=2 "30-49") (1/30=1 "<30"),generate(age4cat)
label variable age4cat "Age, 4 categories"

*77:
tabulate v357 //a)frekvensfordeling for alder
tabulate partychoicetoday if v357 == 17, missing //b)frekvensfordelig for partychoicetoday for 17-årrige inkl. missing

*78:
clonevar partychoicetoday20 = partychoicetoday //kopierer til ny variabel
replace partychoicetoday20 = .e if v357 < 20 //omkoder for respondenter under 20 år

*79:
codebook male v357 //kodebog for variable
clonevar partychoicetoday_male30 = partychoicetoday //opretter partivalgnu_kønalder som kopi af partivalgnu
replace partychoicetoday_male30 = .e if male==1 & v357 <30 //erstatter med .e hvis respondenten er mand og under 30 år

*80
tabulate partychoice, generate(party) //a)
browse partychoice party1-party11 //b)
save "Election05Ch4.dta",replace //c)

*****************************************************
*********************KAPITEL 5***********************
*****************************************************

*84: Søger efter og installerer blindschemes
search blindschemes

*85: Installerer blindschemes og gr0002_3
net install blindschemes, from(http://fmwww.bc.edu/RePEc/bocode/b) replace //a
search gr0002_3 //b
net install gr0002_3, from(http://www.stata-journal.com/software/sj4-3) replace //b

*86: Installerer estout og tabel1_mc fra SSC
ssc install estout, replace 
ssc install table1_mc,replace

*87: Åbner datasættet
use "Election05Ch4.dta", clear

*88: Frekvensfordeling for partychoicetoday
tabulate partychoicetoday 

*89: Lagkagediagram (i farver)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(s1color) //a) lagkagediagram
graph pie, over(partychoice) sort(blue) note(Source: Danish Election Study 2005) scheme(s1color) //b) sorteret efter regeringspræference

*90: Søjlediagram
graph bar, over(partychoice) //a) vertikalt
graph bar, over(partychoice) horizontal //b) horizontalt

*91: Søjlediagram som Figur 5.2
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) ///
	note(The horizontal line represents the barrier for representation; Source: Danish Election Study 2005)

*92: Danner dummyvariable på baggrund af partychoicetoday
tabulate partychoicetoday, generate(partytd)

*93:
ci proportions partytd3, exact //a) 95% konfidensinterval for andelen af observationerne, der angiver, at de ville stemme på De Konservative
bitest partytd6==0.02 //b)Test for om andelen af observationene, der angiver, at de vil stemme på Kristendemokrateren er lig med 2%

*94:
codebook v252, tabulate(20) //a)kodebog for v252; tabulate(20) bevirker at der vises en frekvensfordeling selvom der er mere end 10 unikke værdier
recode v252 (88=.), generate(lrplacement) //b)omkoder til lrplacement, hvor Ved ikke er kodet til missing
summarize lrplacement, detail //c) summarize for lrplacement 

*95: Deskriptive statistikker for lrplacement og v357
tabstat lrplacement v357, statistics(mean sd skewness kurtosis iqr) columns(statistics)

*96: Histogrammer for lrplacement 
histogram lrplacement // histogram for lrplacement, kontinuerlig specifikation
histogram lrplacement, discrete // histogram for lrplacement, diskret specifikation

*97: 4 histogrammer med forskellige målestokker på y-aksen
histogram lrplacement, discrete
histogram lrplacement, discrete fraction
histogram lrplacement, discrete frequency
histogram lrplacement, discrete percent

*98: Inferens for lrplacement
ci mean lrplacement //a) 95% konfidensinterval
ci mean lrplacement,level(99) //a) 99% konfidensinterval
ttest lrplacement == 5 //b) t-test for om gennemsnittet for lrplacement er lig 5

*99: Eksport af frekvensfordeling
estpost tabulate partychoicetoday 
esttab using tab1, cells("b(label(Frekvens)) pct(label(%) fmt(%3,1f))") nonumber nomtitle rtf replace noobs

*100: Eksport af deskriptive statistikker
label variable lrplacement "H/V-placering" //a
label variable v357 "Alder" //a
*b:
estpost tabstat lrplacement v357, statistics(mean sd skewness kurtosis iqr) columns(statistics)
esttab using tab2, ///
cells("mean(label(Gennemsnit) fmt(%3,1f)) sd(label(Std.Afv.) fmt(%3,1f)) skewness(label(Skævhed) fmt(%3,2f)) kurtosis(label(Kurtosis) fmt(%3,2f)) iqr(label(iqr) fmt(%3,0f))") ///
nonumber nomtitle rtf replace noobs label

*101: Eksport af tabel
codebook v357 male birthplace
label variable male "Køn"
table1_mc, vars(v357 contn\ male cat \ birthplace cat) saving(tabel3.xlsx,replace)

*102: oplister tilgængelige skemaer
graph query, schemes

*103a: afprøver schemes
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(s1color)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(s1manual)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(sj)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(economist)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(lean2)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(plotplain)
graph pie, over(partychoice) note(Source: Danish Election Study 2005) scheme(plottig)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(s1color)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(s1manual)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(sj)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(economist)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(lean2)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(plotplain)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(plottig)
*103b: Indstiller stnadard schemes
set scheme lean2, permanently

*104: Navngiver grafer
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(plotplain) name(v1,replace)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(plottig) name(v2,replace)

*105: Sætter graf-preferencer
set autotabgraphs on, permanently
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(plotplain) name(v1,replace)
graph bar, over(partychoice, label(angle(forty_five))) ytitle(Procent) yline(2, lpattern(dash)) scheme(plottig) name(v2,replace)

*106: 
histogram lrplacement, discrete //a) histogram for lrplacement
graph export Fig1, as(jpg) replace //a) eksport af histogram med navnet Fig1 i jpg-format
save "Election05Ch5.dta",replace // gemmer data

*****************************************************
*********************KAPITEL 6***********************
*****************************************************

*109:
use "Election05Ch5.dta", clear //Åbner datasættet
db tabulate2 // dialogboksen til krydstabulering

*110: 
codebook v180
recode v180 (1=0 "tax cuts") (2=1 "service") (8=.), generate(service) label(serviceLB) //omkoder og tildeler value-labels
lab var service "Service (vs. tax cuts)" //tildeler variabel labels
tabulate service male //krydstabulering

*111: Krydstabularing med relative (kolonne-)frekvenser
tabulate service male, column


*112: Sammenligning af to gruppers andele
prtest service, by(male) 

*113: Illustration 
graph bar,  over(service) over(male) asyvars percentage ytitle(%)
graph bar,  over(service) over(male) asyvars percentage ytitle(%) stack


*114: Krydstabulering af male og partychoice
tabulate partychoice male, column

*115:
net install lambda, from(http://fmwww.bc.edu/RePEc/bocode/l) //a Installerer lambda 
lambda partychoice male //b

*116: Catplot for male og partychoice
ssc install catplot
catplot male partychoice, percent(male) 

*117: Chi2-test for male og partychoice
tabulate partychoice male, chi2 column

*118: 
tabulate blue v335,column //a
catplot blue v335, percent(v335) scheme(plottig) //c

*119:
catplot blue v335, percent(v335) asyvars stack scheme(plottig)  //a

*120: Som opg 123 men med specificerede farver
catplot blue v335, percent(v335) asyvars stack bar(1, color(red)) bar(2,color(blue)) scheme(s2color)

*121: Gamma og tau-b
tabulate rc_v188 age4cat, colum gamma taub

*122: Catplot for age4cat og v188
catplot v188 age4cat, percent(age4cat) asyvars stack

*123: ttest for male og lrplacement 
ttest lrplacement, by(male)

*124: Test af varianshomogenitet
robvar lrplacement, by(male)

*125: Dotplot for male og lrplacement 
graph dot lrplacement, over(male) scheme(lean2)

*126: Dotplot fra opg 125, med tilpasninger
graph dot (mean) lrplacement , over(male) scheme(lean2) exclude0 yscale(range(5 6)) /// 
ylabel(5(0.2)6) ytitle("Gennemsnit, lrplacement") 

*127: ciplot for lrplacement over male
ssc install ciplot //installerer ciplot
ciplot lrplacement, by(male)

*128: 
recode v337 (8=.) //a
mean lrplacement, over(v337) //b 

*129: 
graph dot (mean) lrplacement , over(v337) scheme(lean2) exclude0 yscale(range(4.6 6.2)) /// 
ylabel(4.6(0.2)6.2) ytitle("Gennemsnit, lrplacement") //a
ciplot lrplacement, by(v337) //b

*130: 
oneway lrplacement v337,tabulate

*131: 
correlate lrplacement v357
pwcorr lrplacement v357

*132:
correlate intol*
pwcorr intol*, obs
pwcorr intol*, obs listwise

*133: Pairwise correlation med signifikanstest 
pwcorr lrplacement v357, sig

*134: Scatterplot
scatter lrplacement  v357

*135: alternative plots
scatter lrplacement  v357,jitter(1) msize(vtiny) //a
sunflower lrplacement  v357 //b

*136: 
save Election05Ch6.dta,replace //gemmer datasættet
use DifferentGoodsCh3.dta //åbner datasæt

*137: Scatterplot
scatter gst git //a) scatterplot
pwcorr gst git,sig //b) korrelation og P-værdi

*138: Scatterplot via menuen
twoway (scatter gst git)

*139: Samme plot, men med landenavne 
twoway (scatter gst git, mlabel(country))

*140: 
twoway (scatter gst git, mlabel(country)) (lfit gst git) //som før men med OLS linje
twoway (scatter gst frac, mlabel(country)) (lfit gst frac) //nye variable

*142
use Election05Ch6.dta //åbner datasættet
*eksport af krydstabel til fil med navn ktabel1 i aktiv mappe:
estpost tabulate partychoice male
esttab using ktabel1, cell(colpct(fmt(%2,1f))) unstack noobs replace collabels(none) nonumber nomtitle

*143: Konfidenintervaller med tre stikprøvestørrelser
cii proportions  250 (0.52*250)  //250
cii proportions  750 (0.52*750)  //500
cii proportions 1000 (0.52*1000) //1000

*144: Gamma-koefficient for sammenhængen mellem var3 og var4
tabi 30	20 \ 40	10 \ 45 5, gamma

*145: Åbner hjælpefilen til tabulate
h tabulate twoway

*146:
tab service male, gamma taub //b
return list  //c

*147: Beregner gamma
display r(gamma)

*148: Beregner gamma med standardfejl
display r(gamma)/r(ase_gam)

*149: Beregner P-værdi og tau-b
display normal(r(taub)/r(ase_taub))


*****************************************************
*********************KAPITEL 7***********************
*****************************************************

*150: Åbner data
use "Election05Ch6.dta", clear

*151: Kodebog 
codebook rc_v184 rc_v188 rc_v195 rc_v224 rc_v226 

*152: 
recode rc_v184 (1=1) (2=3) (3=5) //omkoder rc_v184 til ny variationsbredde
recode rc_v188 rc_v224 rc_v226 (1=5) (2=4) (3=3) (4=2) (5=1) //vender items

*153: item-item-analyser med gamma og Pearsons r
tab2 rc_*,gamma
pwcorr rc_*

*154: reliabilitetstest 
alpha rc_* , item casewise 

*155: danner tempindeks, kun observationer med mindst to gyldige værdier medtages
alpha rc_* , min(2) generate(tempscale) item

*156:
su tempscale //summarize for indekset
generate intolerance = ((tempscale-1)/(5-1))*100 //reskalerer, så det nye indeks går fra 0-100

*157:
sum intolerance,detail //summarize for indekset
histogram intolerance //histogram
drop tempscale //sletter tempscale

*158:
foreach var in v188 v195 {
recode `var' (8=.a),generate(`var'mis)
sum `var'mis
replace `var'mis = r(mean) if `var'mis ==.a
}

*159: sletter og gemmer
drop v188mis v195mis
save "Election05Ch7.dta",replace


*****************************************************
*********************KAPITEL 8***********************
*****************************************************

*160: åbner data
use "Election05Ch7.dta", clear

*161: bivariat regression
reg intolerance v357

*162:
reg intolerance v357, beta //som før men med beta
pwcorr intolerance v357, sig obs  //pearsons r

*163:
reg intolerance male //mænd og kvinders fremmedskepticisme med regress
ttest intolerance, by(male)  //samme med ttest

*164:
tab v337, generate(durban)  //danner dummevariable
reg intolerance durban2-durban5  //sammenhængen mellem urbanisering og fremmedskepticisme med regress + dummyvariable

*165:
reg intolerance i.v337 //som foregående men med faktorvariable

*166: Fælles F-test
testparm i.v337

*167
reg intolerance ib(3).v337 //som 165 men med kategori 3 som reference

*168:
codebook v314,tabulate(25)
recode v314 (1=1 native) (nonmis=0 immigrant),generate(native)

*169:
reg intolerance v357 i.native i.male

*170:
reg intolerance v357 i.native i.male,robust

*171:
reg intolerance i.highschool //Model 1
reg intolerance i.highschool v357 i.native i.male //Model 2
reg intolerance i.highschool v357 i.native i.male i.v337 //Model 3

*172:
reg intolerance i.highschool v357 i.native i.male i.v337 //Model 3
reg intolerance i.highschool v357 i.native i.male if e(sample) == 1 //Model 2
reg intolerance i.highschool if e(sample)==1 //Model 1

*173
reg intolerance i.highschool v357 i.native i.male i.v337
eststo m3
reg intolerance i.highschool v357 i.native i.male if e(sample) == 1
eststo m2
reg intolerance i.highschool if e(sample)==1
eststo m1
esttab m1 m2 m3, label

*174
esttab m1 m2 m3 using tabel1, r2 ar2 se replace

*175
regress intolerance i.male v357 i.v337 //a
margins v337, pwcompare(effects) //b

*176
margins v337, pwcompare(effects groups) 

*177
margins v337, at((mean) _c male=0)

*178
generate intol101 = intolerance + 1 //a) reskallerer intolerance
generate lnintol = ln(intol101) //b) tranformerer intol101
regress lnintol v357 i.male //b) logaritmisk regression
regress intolerance c.v357##c.v357 i.male //c) kvadratisk regression
save "Election05Ch8.dta",replace //d) Gemmer data

*179
ssc install coefplot
net install marginscontplot2, from(http://fmwww.bc.edu/RePEc/bocode/m)

*180
*venstre plot i figur 8.2
regress intolerance i.male v357 i.v337 //regressionen
margins v337 //beregner gennemsnit ud fra regressionen
marginsplot, /// 
recast(scatter) ///fjerner linjer mellem punkter
ytitle(Intolerance) ///ændrer titlel på Y-aksen
xtitle ("") /// fjerner titlen på x-aksen
xlabel(, angle(30)) /// drejer labels på X 30 grader
title("Forudsagte gennemsnit") /// tilføjer titel
note("Estimater med 95% konfidensintervaller", placement(c)) //tilføjer note, centreret

*højre plot i figur 8.2
regress intolerance i.male v357 i.v337 //regressionen
margins v337, pwcompare(effects) //beregner forskelle
marginsplot, ///
horizontal unique recast(scatter) yscale(reverse) /// svært at forklare...
xline(0) ///indsætter vertikal linje
ytitle(Sammenligninger) /// ændrer titlen på Y-aksen
title("Sammenligning af gennemsnit") /// tilføjer titel
xtitle(Forskel) ///Ændrer titlel på X-aksen
note("95 % konfidensintervaller""Grupper: 1: Rural, 2: Town, <10.000" /// tilføjer noter
"3: Town, 10-50.000, 4: Town, 50-500.000, 5: Metropolitan area" /// do
,placement(c) justification(c)) // placerer noten i midten


*181
regress intolerance i.male v357 //regressionen
marginscontplot2 v357, at1(18 (2) 80) ///
ci ///tilføjer konfidensintervallet
plotopts(ytitle("Intolerance") xtitle("Alder (år)")) //ændrer titlen på X- og Y-aksen

*kommandoerne bag figur 8.4 - ikke en opgave
reg intolerance i.male v357 i.native //regressionen
marginscontplot2 v357 male, ///
plotopts(ytitle("Intolerance") xtitle("Age (years)") ///ændrer titlen på X- og Y-aksen
legend(ring(0) ///flytter forklaringen ind i grafen
lab(1 "Female") lab(2 "Male")) ///ændrer labels
note("The control variable 'country of birth' is held at the observed values",placement(center))) //note, centreret


*182:
reg intolerance i.male v357 i.native //regressionen
marginscontplot2 v357 male

*183:
regress intolerance c.v357##c.v357 i.male //kvadratisk regression
marginscontplot2 v357, ci ///
plotopts(ytitle("Intolerance") xtitle("Alder (år)"))

*184:
reg intolerance i.highschool v357 i.native i.male i.v337
eststo m3
reg intolerance i.highschool v357 i.native i.male if e(sample) == 1
eststo m2
reg intolerance i.highschool if e(sample)==1
eststo m1
coefplot  /// starter coefplot
(m1,label("Uden kontrol")) ///labler model 1
(m2,label("+køn, alder og fødeland")) /// labler model 2
(m3,label("+urbanisering")), /// labler model 3
keep(1.highschool) /// se forklaring ovenfor
vertical /// specificerer at plottet skal være vertikalt
level(99 95) /// specificerer konfidensintervaller 
legend(row(1) position(6)) ///specificerer at forklaringen skal stå på én række under figuren
ytitle("Koefficient, uddannelse") xlabel("") ///Tilføjer og fjerne titler på akserne
note("Konfidensintervaller: 95% (bred) 99% (smal)",placement(center))  //tilføjer note, centreret
*Simpel udgave
coefplot m1 m2 m3, keep(1.highschool)


*****************************************************
*********************KAPITEL 9***********************
*****************************************************
*185:
use election05Ch8,clear  //a) åbner data
reg intolerance v357  male //b) regression
acprplot v357, lowess //c) acpr-plot for alder

*186: leverage-versus-residual-squared-plot
lvr2plot

*187:
predict tempcooksd, cooksd  //beregner cook's d
display 4/e(N) //udregner kritisk værdi
summarize tempcooksd if tempcooksd >(4/e(N)) //opsummerer observationer med kritiske værdier

*188:
browse if tempcooksd >(4/e(N)) & tempcooksd <.

*189: avplots
avplots

*190: DFBETA
predict tempdfbeta, dfbeta(v357) //a
summarize tempdfbeta if abs(tempdfbeta) > 2/sqrt(e(N)) //b

*191: Histogram
*beregning af residualer, der gemmes i variablen 'tempresid':
predict tempresid, residuals
*Histogram, inkl. normalfordelingskurve, for residualernes fordeling:
histogram tempresid, normal

*192: q-q-plot
qnorm tempresid

*193: 
rvfplot,yline(0) //rvfplot
rvpplot v357, yline(0)
*rvpplot male, yline(0)

*194: White's test
estat imtest,white

*195: VIF
vif

*196:
drop temp* //rydder op

*****************************************************
*********************KAPITEL 10**********************
*****************************************************

*197: Åbner data
use "GrowthCh10.dta", clear

*198: regressionsmodellen
reg  meangrowth aidcap goodgov initial forinvest eduyears,robust  //uden interaktion
reg  meangrowth aidcap goodgov c.aidcap#c.goodgov initial forinvest eduyears,robust  //med interaktion

*199: statistikker for variblene fra forrige estimation baseret på estimationssamplen
estat summarize

*200: Beregning af marginale effekter
margins, dydx(aidcap) at(goodgov=(-1.8(0.2)1.8)) vsquish

*201: marginsplot
marginsplot

*202: Illustration af Figur 10.5
marginsplot, /// starter kommandoen marginsplot
recast(line) /// beder om en linje fremfor punkter
recastci(rline) /// specificerer ar konfidensintervallet også skal tegner med linjer
ciopts(lpattern(dash)) /// specificerer at konfidensintervallet skal tegnes med stiplede linjer
yline(0) /// indsætter en linje ved y=0
xlabel(#5) /// nedjusterer antallet af tal på x-aksen
legend(on position(6) /// beder om at få vist forklaring under plottet
label(1 "95% konfidensinterval") /// specificerer forklaringen
label(2 "Marginal effekt af ulandshjælp")) /// specificerer forklaringen
xtitle("Institutionel kvalitet") /// indsætter alternativ titel på x-aksen
ytitle("Marginal effekt af ulandshjælp") /// indsætter alternativ titel på y-aksen
title("") /// fjerner den overordnede titel
scheme(plotplain) //sætter scheme

*203
summarize goodgov if e(sample),detail
margins, dydx(aidcap) at(goodgov=(`r(p10)' `r(p50)' `r(p90)'))

*204
sum goodgov if e(sample),detail
margins, at(aidcap=(0 130) goodgov=(`r(p10)' `r(p50)' `r(p90)'))
marginsplot, noci

*kommandoen bag figur 10.4 (ikke en opgave)
marginsplot, noci ///marginsplot uden konfidensintervaller
recast(line) ///fjerner punkterne
ytitle("Gennemsnitlig årlig vækst (%)") ///ændrer titlen på Y-aksen
xtitle("Ulandsbistand per capita ($)") /// ændrer titlen på X-aksen
title("") ///fjerner titel
legend (order(3 2 1) position(6) ///ændrer forklaringer
label(1 "Lav institutionel kvalitet *") ///
label(2 "Middel institutionel kvalitet *") ///
label(3 "Høj institutionel kvalitet *")) ///
note("*: P< 0,05; Lav, Middel, Høj institutionel kvalitet: 10. 50. og 90. percentil" ///
"Kontrolvariable er holdt på deres observerede værdier" ///tilføjer noter
,size(small) placement(6) justification(center)) ///notens størrelse og placering
scheme(plotplain) //sætter scheme


*205
summarize goodgov if e(sample),detail
margins, dydx(aidcap) at(goodgov=(`r(min)' `r(mean)' `r(max)'))
sum goodgov if e(sample),detail
margins, at(aidcap=(0 130) goodgov=(`r(min)' `r(mean)' `r(max)'))
marginsplot, noci ///marginsplot uden konfidensintervaller
recast(line) ///fjerner punkterne
ytitle("Gennemsnitlig årlig vækst (%)") ///ændrer titel på Y-aksen
xtitle("Ulandsbistand per capita ($)") /// ændrer titel på X-aksen
title("") ///fjerner titel
legend (order(3 2 1) position(6) ///ædrer forklaringer
	label(1 "Lav institutionel kvalitet *") ///
	label(2 "Middel institutionel kvalitet ") ///
	label(3 "Høj institutionel kvalitet *")) ///
	note("*: P< 0,05; Lav, Middel, Høj institutionel kvalitet: minimum, middel og maximum" ///
	"Kontrolvariable er holdt på deres observerede værdier" ///tilføjer noter
	,size(small) placement(6) justification(center)) ///notens størrelse og placering
	scheme(plotplain) //ændrer scheme

*Figur 10.6 - ikke en opgave
reg meangrowth c.aidcap##goodgov01 initial forinvest eduyears,robust //regressionen
margins, dydx(aidcap) at(goodgov01=(0 1)) //marginale effekter
marginsplot, ///marginsplot
recast(scatter) /// ændrer fra linje til punkter
yline(0) ///indsætter linje ved Y=0
xscale(range(-0.1 1.1)) /// udvider variationsbredden for X-aksen
xtitle("Quality of Institutions") /// ændrer titel på X-aksen
ytitle(Marginal effect of Foreign aid) ///ændrer titel på Y-aksen
title("") ///fjerner overordnet titel
scheme(plotplain) ///ændrer scheme
xsize(3) //gør figuren smallere


*Figur 10.7 - ikke en opgave
reg meangrowth i.aidcap01##c.goodgov initial forinvest eduyears,robust //regressionen  
margins, dydx(aidcap01) at(goodgov=(-1.8(0.2)1.8)) //marginale effekter
marginsplot , ///
recast(line) /// beder om en linje fremfor punkter
recastci(rline) /// specificerer at konfidensintervallet også skal tegnes med linjer
ciopts(lpattern(dash)) /// specificerer at konfidensintervallet skal tegnes med stiplede linjer
yline(0) /// indsætter en linje ved y=0
xlabel(#5) /// nedjusterer antallet af tal på x-aksen
legend(on position(6) /// beder om at få vist forklaring
label(1 "95% Confidence interval") /// specificerer forklaringen
label(2 "Marginal effect")) /// specificerer forklaringen
xtitle("Quality of institutions") /// indsætter alternativ titel på x-aksen
ytitle("Marginal effect of aid on growth""(Difference between heavy and light recievers)") ///
title("") /// fjerner den overordnede titel
scheme(plotplain) // optimerer til sort/hvid-visning

*****************************************************
*********************KAPITEL 11**********************
*****************************************************
*Blok 1
*Klargør data fra Blom-Hansen, Houlberg & Serritzlew (2014)
use "The economic cots of running the political system_20131120_2.dta"
gen byte amalgamated = 0
replace amalgamated = d_amalgamated if year >2006
drop d_amalgamated
keep if fil==1
keep muni amalgamated admin_costs_pc_11pl year cpr d_popgrp1 ///
children_oneparentfamilies_p socialhousingp_0605_0809_1110 ///
fiscalpressure traveltime_pc_05og0607 adm_dec_degree_10pl_20072008
order cpr municipalityname year admin_costs_pc_11pl amalgamated ///
children_oneparentfamilies_p
lab var municipalityname "Municipality name"
lab var year Year
lab var amalgamated Amalgamated
rename cpr id
lab var id "Municipality id"
rename admin_costs_pc_11pl admin_costs
lab var admin_costs "Administrative costs per capita (2011 prices)"
rename children_oneparentfamilies_p children_oneparent
lab var children_oneparent "Children in one-parant families (%)"
rename d_popgrp1 small_island
rename socialhousingp_0605_0809_1110 socialhousing
rename traveltime_pc_05og0607 dispersal
rename adm_dec_degree_10pl_20072008 adm_dec_degree
compress
save "BlomHansenEtAL",replace

*Blok 2*
use "BlomHansenEtAL",clear //åbner data
*Figur 11.5
br //datamatricen
*Figur 11.6
xtsum admin_cost,i(id)
*Figur 11.7
xtline admin_costs, ///xtline og den afhængige variabel
i(id) t(year) /// specificerer enheds- og tids-variablene
overlay ///alle linjer i én figur
legend(off) ///slår legend fra
xlabel(2005(1)2011) ///bestiller labels fra 2005 til 2011 på x-aksen
ylabel(,nogrid) //slår vandrette streger fra
*Figur 11.8
regress admin_costs i.year,cluster(id) //GNS + CI henover år
margins, at(year=(2005(1)2011)) //overflytter resultater til margins
marginsplot, /// plotter med marginsplot
ytitle("Administrative udgifter per capita (kroner)") ///
xtitle(År) ///ændrer titlen på Y- og X-aksen
title("") ylab(,nogrid) //fjerner titel og vandrette streger
*Figur 11.9
tabulate amalgamated year
*generering af TG ud fra amalgamated
egen TG = max(amalgamated), by(id)
*Figur 11.10: Tabulering af TG og tid
tab TG year
*Figur 11.11
regress admin_costs TG##year if year == 2006 | year==2007, cluster(id)

***Blok 3/Figur 11.12***
/*01*/ regress admin_costs TG##year if year == 2006 | year==2007, cluster(id)
/*02*/ margins, at(TG=(0 1) year=(2006 2007)) post
/*03*/ matrix A = e(b)
/*04*/ matrix list A
/*05*/ global M00 = A[1,1]
/*06*/ global M01 = A[1,2]
/*07*/ global M10 = A[1,3]
/*08*/ global M11 = A[1,4]
/*09*/ global M11c = A[1,3]+(A[1,2]-A[1,1])
/*10*/ tw (scatteri $M00 2006 $M01 2007, connect(line) m(o) mc(gs10) lc(gs10)) ///
/*11*/ (scatteri $M10 2006 $M11c 2007, connect(line) m(o) mc(gs10) lc(gs10) mc(gs10) lp(dash)) ///
/*12*/ (scatteri $M10 2006 $M11 2007, connect(line) m(o)) ///
/*13*/ , ///
/*14*/ xlabel(2006 2007) ///
/*15*/ xscale(range(2005.9 2007.1)) ///
/*16*/ ylabel(,nogrid) ///
/*17*/ xtitle(År) ytitle("Administrative omkostninger pr. indbygger", size(medsmall)) ///
/*18*/ legend(label (1 "Kontrolgruppens udvikling") label (3 "Treatmentgruppens udvikling") ///
/*19*/ label (2 "Kontrakfaktisk udvikling") ///
/*20*/ order(1 3 2))

*Blok 4/Figur 11.13
regress admin_costs TG##year if year >= 2006, cluster(id)
*Figur 11.14
regress admin_costs TG##year if year >= 2006, cluster(id)
margins, at(TG=(0 1) year=(2006 (1) 2011)) post
mat A = e(b)
global M00 = A[1,1]
global M01 = A[1,2]
global M02 = A[1,3]
global M03 = A[1,4]
global M04 = A[1,5]
global M05 = A[1,6]
global M10 = A[1,7]
global M11 = A[1,8]
global M12 = A[1,9]
global M13 = A[1,10]
global M14 = A[1,11]
global M15 = A[1,12]
global M10c = A[1,7]
global M11c = A[1,7]+(A[1,2]-A[1,1])
global M12c = A[1,9]+(A[1,3]-A[1,2])
global M13c = A[1,9]+(A[1,4]-A[1,2])
global M14c = A[1,9]+(A[1,5]-A[1,2])
global M15c = A[1,9]+(A[1,6]-A[1,2])
tw ///
(scatteri $M00 2006 $M01 2007 $M02 2008 $M03 2009 $M04 2010 $M05 2011 ///
, connect(line) m(o) mc(gs10) lc(gs10)) ///
(scatteri $M10c 2006 $M11c 2007 $M12c 2008 $M13c 2009 $M14c 2010 $M15c 2011 ///
, connect(line) m(o) mc(gs10) lc(gs10) mc(gs10) lp(dash)) ///
(scatteri $M10 2006 $M11 2007 $M12 2008 $M13 2009 $M14 2010 $M15 2011, connect(line) m(o)) ///
, ///
xlabel(2006 (1) 2011) xscale(range(2005.9 2011.1)) ylabel(,nogrid) xtitle(År) ///
ytit("Administrative omkostninger pr. indbygger", size(medsmall)) ///
legend(label (3 "Treatmentgruppens udvikling") label (2 "Kontrakfaktisk udvikling") ///
label (1 "Kontrolgruppens udvikling") order(1 3 2) position(6))

*Blok 5/Figur 11.15
regress admin_costs TG##ib2006.year, cluster(id)
*Figur 11.16
regress admin_costs TG##ib2006.year, cluster(id)
margins, at(TG=(0 1) year=(2005(1) 2011)) post
mat A =e(b)
global M00 = A[1,1]
global M01 = A[1,2]
global M02 = A[1,3]
global M03 = A[1,4]
global M04 = A[1,5]
global M05 = A[1,6]
global M06 = A[1,7]
global M10 = A[1,8]
global M11 = A[1,9]
global M12 = A[1,10]
global M13 = A[1,11]
global M14 = A[1,12]
global M15 = A[1,13]
global M16 = A[1,14]
global M10c = A[1,9]+(A[1,1]-A[1,2])
global M11c = A[1,9]
global M12c = A[1,9]+(A[1,3]-A[1,2])
global M13c = A[1,9]+(A[1,4]-A[1,2])
global M14c = A[1,9]+(A[1,5]-A[1,2])
global M15c = A[1,9]+(A[1,6]-A[1,2])
global M16c = A[1,9]+(A[1,7]-A[1,2])
tw ///
(scatteri $M00 2005 $M01 2006 $M02 2007 $M03 2008 $M04 2009 $M05 2010 $M06 2011 ///
, connect(line) m(o) mc(gs10) lc(gs10)) ///
(scatteri $M10c 2005 $M11c 2006 $M12c 2007 $M13c 2008 $M14c 2009 $M15c 2010 $M16c 2011 ///
, connect(line) m(o) mc(gs10) lc(gs10) mc(gs10) lp(dash)) ///
(scatteri $M10 2005 $M11 2006 $M12 2007 $M13 2008 $M14 2009 $M15 2010 $M16 2011, connect(line) m(o)) ///
, ///
xlabel(2005 (1) 2011) xscale(range(2004.9 2011.1)) ylabel(,nogrid) xtitle(År) ///
ytitle("Administrative omkostninger pr. indbygger", size(medsmall)) ///
legend(label (3 "Treatmentgruppens udvikling") label (2 "Kontrakfaktisk udvikling") ///
label (1 "Kontrolgruppens udvikling") order(1 3 2) position(6))
	
*Figur 11.17
reg admin_costs TG##ib2006.year children_oneparent small_island,cluster(id)



*****************************************************
*********************KAPITEL 12**********************
*****************************************************
*208
findit spost
net install spost9_ado, from(https://www.indiana.edu/~jslsoc/stata)

*209
use "election05Ch8",clear

*210
codebook blue

*211
codebook male v357 v337 v334 intolerance,tabulate(100) //a
recode v334 (88=.) //b

*212
logit blue i.male v357 i.v337 v334 intolerance

*213
fitstat

*214
margins, dydx(*)

*215
margins, dydx(*) atmeans

*216
margins, dydx(*) at(male=1 v337=3) atmeans //a
margins, dydx(*) at(male=1 v337=1) atmeans //b

*217
margins, at((p25) intolerance) at((p75) intolerance)

*218
margins v337

*219
logit blue i.male v357 v334 i.v337 intolerance,or //metode 1
listcoef //metode 4

*220
listcoef, reverse

*221
marginscontplot2 intolerance, ci

*222
logit blue i.male v357 i.v337 v334 intolerance //regressionen
summarize intolerance if e(sample), detail //udregner percentiler
marginscontplot2 intolerance, ci ///
plotopts ///
(ytitle("Gns. forudsagt sandsynlighed for blå stemme") /// titel på Y-aksen
xtitle("Intolerance") /// titel på Y-aksen
xline(`r(p25)' `r(p75)') /// indsætter lodrette linjer
note("Noter: 95% konfidensinterval. De lodrette linjer repræsenterer hhv. 25. og 75. percentiel", ///
size(small) pos(6)) /// note, størrelse og placering
scheme(plotplain)) //scheme

*223
margins v337
marginsplot

*224
margins v337
marginsplot, ///
recast(scatter)  /// fjerner linjer mellem punkter
ytitle(Gennemsnitlig forudsagt sandsynlighed for blå stemme) ///Y-titlen
xlabel(, labsize(vsmall) angle(forty_five)) /// formindsker og drejer labels
xtitle(Urbanisering) /// X-titlen
xscale(range(0.5 5.5)) ///udvider X-aksen
title("") //fjerner titel

*225
logit blue intolerance
predict tempprop1
twoway (lowess blue intolerance) (line tempprop1 intolerance,sort)

*226
logit blue lnintol 
predict tempprop2 
twoway (lowess blue lnintol) (line tempprop2 lnintol,sort)

*227
logit blue i.male v357 v334 i.v337 intolerance
summarize intolerance if e(sample)==1
generate tempvar = autocode(intolerance, 10, r(min), r(max))
egen ordvar1 = group(tempvar)
logit blue i.male v357 v334 i.v337 i.ordvar
margins ordvar,predict(xb)
marginsplot
drop tempvar

*****************
***Appendiks G***
*****************
*G1
use "Election05Ch6.dta",clear //a
codebook blue male rc_v188 //b

*G2
tabulate blue rc_v188,gamma //a
bysort male: tabulate blue rc_v188,gamma //b

*G3
catplot blue rc_v188, percent(rc_v188 male) over(male) asyvars stack 

*****************
***Appendiks H***
*****************
*H1
use "Election05Ch6.dta",clear //a
recode rc_v184 (1=1) (2=3) (3=5) //b)omkoder rc_v182 til ny variationsbredde
recode rc_v188 rc_v224 rc_v226 (1=5) (2=4) (3=3) (4=2) (5=1) //b)vender items
//c:
gen Src_v184 = rc_v188 + rc_v195 +  rc_v224 + rc_v226
gen Src_v188 = rc_v184 + rc_v195 +  rc_v224 + rc_v226
gen Src_v195 = rc_v184 + rc_v188 +  rc_v224 + rc_v226
gen Src_v224 = rc_v184 + rc_v188 +  rc_v195 + rc_v226
gen Src_v226 = rc_v184 + rc_v188 +  rc_v195 + rc_v224 
foreach var in rc_v188 rc_v195 rc_v224 rc_v226 {
tabulate S`var' `var', gamma nofreq
}
alpha rc_v184 rc_v188 rc_v195  rc_v224 rc_v226, casewise item //d





