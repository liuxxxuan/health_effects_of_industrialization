
************Descriptive statistics*********************

qui estpost sum chronic cesd10 chronic_L1 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 ///
    age gender marry edu rural_L1 act_1_L1 sleep_L1 pension_L1, detail
	
esttab using detail.csv, cells("mean(fmt(3)) sd(fmt(3)) p50(fmt(3))")


***************Baseline regressions********************


global controls "age gender marry edu rural_L1 act_1_L1 sleep_L1 pension_L1"
global  fe "city_code year"


//chronic

reghdfe chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 , a($fe)
est store m1
reghdfe chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)
est store m2  

//cesd10

reghdfe cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 , a($fe)
est store m3
reghdfe cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)
est store m4  

//

esttab m1 m2 using baseline_chor.csv, replace mtitle(`m') compress nogap   ///
       b(%6.2f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01)
	   
esttab m3 m4 using baseline_cesd.csv, replace mtitle(`m') compress nogap   ///
       b(%6.2f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01)
	  
	  
***************Robustness check********************	  


//Here we add control variables to control the impact of omitted variables

reghdfe chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls     ///
        ea001s1_L1 fcamt_L1 family_size_L1 hchild_L1 hope_L1, a($fe)
est store m5 

esttab m5 using r1_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01)

reghdfe cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls     ///
        ea001s1_L1 fcamt_L1 family_size_L1 hchild_L1 hope_L1, a($fe)
est store m6

esttab m6 using r1_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01)

	   
// robust standard error

reghdfe chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe) vce(robust)
est store m7

esttab m7 using r2_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01)
	   
reghdfe cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe) vce(robust)
est store m8

esttab m8 using r2_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f) star(* 0.1 ** 0.05 *** 0.01)

	   
// Logit regression


logit chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls i.city_code i.year
est store m9

esttab m9 using r3_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f) drop(*city_code*) star(* 0.1 ** 0.05 *** 0.01)

logit cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls i.city_code i.year	   
est store m10

esttab m10 using r3_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f) drop(*city_code*) star(* 0.1 ** 0.05 *** 0.01)

   
   
***************Heterogeneity analysis********************	


*Here we divide chronic diseases into eight categories


gen circulatory = hibpe + hearte + stroke
replace circulatory = 1 if circulatory >= 1
gen respiratory = lunge + asthmae
replace respiratory = 1 if respiratory >= 1
gen endocrine = diabe + dyslipe
replace endocrine = 1 if endocrine >= 1
gen oncology = cancre
gen urinary = kidneye
replace urinary = 1 if urinary >= 1
gen mental = psyche + memrye
replace mental = 1 if mental >= 1
gen digestive = digeste + livere
replace digestive = 1 if digestive >= 1
gen arthritis = arthre
replace arthritis = 1 if arthritis >= 1
gen circulatory_L1 = hibpe_L1 + hearte_L1 + stroke_L1
replace circulatory_L1 = 1 if circulatory_L1 >= 1
gen respiratory_L1 = lunge_L1 + asthmae_L1
replace respiratory_L1 = 1 if respiratory_L1 >= 1
gen endocrine_L1 = diabe_L1 + dyslipe_L1
replace endocrine_L1 = 1 if endocrine_L1 >= 1
gen oncology_L1 = cancre_L1
gen urinary_L1 = kidneye_L1
replace urinary_L1 = 1 if urinary_L1 >= 1
gen mental_L1 = psyche_L1 + memrye_L1
replace mental_L1 = 1 if mental_L1 >= 1
gen digestive_L1 = digeste_L1 + livere_L1
replace digestive_L1 = 1 if digestive_L1 >= 1
gen arthritis_L1 = arthre_L1
replace arthritis_L1 = 1 if arthritis_L1 >= 1


reghdfe circulatory circulatory_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe respiratory respiratory_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe endocrine endocrine_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe oncology oncology_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe urinary urinary_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe mental mental_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe digestive digestive_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)

reghdfe arthritis arthritis_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls , a($fe)



**********Heterogeneity analysis of industrial land transfer***********


**1.price


global controls "age gender marry edu rural_L1 act_1_L1 sleep_L1 pension_L1"
global  fe "city_code year"


reghdfe chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls if num==1 , a($fe)
est store h1

reghdfe chronic chronic_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls if num==0 , a($fe)
est store h2

esttab h1 h2 using price_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)

reghdfe cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls if num==1 , a($fe)
est store h3

reghdfe cesd10 cesd10_L1 ratio1_L1 ratio1_L2 ratio1_L3 $controls if num==0 , a($fe)
est store h4

esttab h3 h4 using price_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)

	   
**2.type


global controls "age gender marry edu rural_L1 act_1_L1 sleep_L1 pension_L1"
global  fe "city_code year"


reghdfe chronic chronic_L1 rxy_L1 rxy_L2 rxy_L3 $controls , a($fe)
est store h5

esttab h5 using t1_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)
	   
reghdfe chronic chronic_L1 rzpg_L1 rzpg_L2 rzpg_L3 $controls , a($fe)
est store h6

esttab h6 using t2_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)
	  
reghdfe cesd10 cesd10_L1 rxy_L1 rxy_L2 rxy_L3 $controls , a($fe)
est store h7

esttab h7 using t1_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)
	   
reghdfe cesd10 cesd10_L1 rzpg_L1 rzpg_L2 rzpg_L3 $controls , a($fe)
est store h8

esttab h8 using t2_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)
	   

**3.sector


global controls "age gender marry edu rural_L1 act_1_L1 sleep_L1 pension_L1"
global  fe "city_code year"


reghdfe chronic chronic_L1 high_poll_L1 high_poll_L2 high_poll_L3 $controls , a($fe)
est store h9

esttab h9 using poll_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)
	   
reghdfe chronic chronic_L1 high_tech_L1 high_tech_L2 high_tech_L3 $controls , a($fe)
est store h10

esttab h10 using tech_chor.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)

reghdfe cesd10 cesd10_L1 high_poll_L1 high_poll_L2 high_poll_L3 $controls , a($fe)
est store h11

esttab h11 using poll_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)
	   
reghdfe cesd10 cesd10_L1 high_tech_L1 high_tech_L2 high_tech_L3 $controls , a($fe)
est store h12

esttab h12 using tech_cesd.csv, replace mtitle(`m') compress nogap  ///
       b(%6.2f) t(%6.2f)  star(* 0.1 ** 0.05 *** 0.01)	   
	   
  
 
