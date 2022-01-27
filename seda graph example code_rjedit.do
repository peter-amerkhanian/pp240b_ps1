use "C:\Users\Rucker\Desktop\old laptop files\Rucker Johnson\Documents\QuantPP240B_Spring2022\small SEDA v30 district data for example code.dta", clear

sum meangs [aw=mnenrol], detail
corr meangs ses

gen ses2 = ses^2 
gen ses3 = ses^3 

*------------------------------------------------------------------------------
*general scheme 
*------------------------------------------------------------------------------
graph set window fontface "Calibri Light"

set scheme economist
glob background "edkblue"
glob background ""9 66 169""


*----------------------------------------
*make figures of mean achievement by SES 
/* allows nonlinearity with inclusion of quadratic specification (squared and cubic terms)--this goes beyond what we've covered so far but includes what we will introduce in future class periods; 
(NOTE: for problem set, students were expected to only include bivariate linear specification)--this is far more elaborate than expected from students--I am just providing polished syntax to create professional-looking figures (as an illustration/example) */
*----------------------------------------

reg meangs ses ses2 ses3 if abs(meangs)<=5 & abs(ses)<4 [aw=mnenrol]
sum ses if e(sample)

	twoway (scatter meangs ses [aw=mnenrol], msym(Oh) mlc(white) mlw(vthin) msize(small)) ///
		(function y = `=_b[_cons]' + `=_b[ses]'*x + `=_b[ses2]'*x^2 + `=_b[ses3]'*x^3, ran(-4 3) lc(maroon) lp(dash) lw(thin)) ///
		if abs(meangs)<=5 & abs(ses)<4 ///
		, ///
		title("Academic Achievement and Socioeconomic Status", size(vlarge) color(white)) ///
		subtitle("US School Districts, 2009-2016", size(medlarge) color(white)) ///
		xlab(-4(1)3 ///
			, labsize(small) angle(hori) labc(white) tlcolor(white)) ///
		ysc(titlegap(2)) ///
		xsc(ran(-4 3) lc(white) titlegap(2)) ///
		ylin(0, lc(gs14) lw(vthin) lp(dash)) ///
		ylab(-5(1)4, angle(hori) labsize(small) format(%3.0f) nogrid labc(white)) ///
			ytitle("Average Achievement (Grade Levels)", color(white) size(large)) ///
		xtitle("                     <----- Poor/Disadvantaged ------------------- Affluent/Advantaged ----->", color(white) size(large)) ///
		leg(off) ///
		xsize(13.33) ysize(7.5) ///
		graphregion(c(${background})) ///
		name(meanses, replace)

		
		
*preserve		
	gen meangstop100 = meangs if top100==1	
	twoway (scatter meangs ses [aw=mnenrol], msym(Oh) mlc(gs9) mlw(vthin) msize(small)) ///
		(scatter meangstop100 ses [aw=mnenrol], msym(O) mc("255 230 153") mlc(black) mlw(vvthin) msize(small)) ///
		(function y = `=_b[_cons]' + `=_b[ses]'*x + `=_b[ses2]'*x^2 + `=_b[ses3]'*x^3, ran(-4 3) lc(maroon) lp(dash) lw(thin))  ///
		if abs(meangs)<=5 & abs(ses)<4 ///
		, ///
		title("Academic Achievement and Socioeconomic Status", size(vlarge) color(white)) ///
		subtitle("100 Largest US School Districts, 2009-2016", size(medlarge) color(white)) ///
		xlab(-4(1)3 ///
			, labsize(small) angle(hori) labc(white) tlcolor(white)) ///
		ysc(titlegap(2)) ///
		xsc(ran(-4 3) lc(white) titlegap(2)) ///
		ylin(0, lc(gs14) lw(vthin) lp(dash)) ///
		ylab(-5(1)4, angle(hori) labsize(small) format(%3.0f) nogrid labc(white)) ///
			ytitle("Average Achievement (Grade Levels)", color(white) size(large)) ///
		xtitle("                     <----- Poor/Disadvantaged ------------------- Affluent/Advantaged ----->", color(white) size(large)) ///
		leg(ring(0) cols(1) pos(4) size(medsmall) region(fc(${background}) lc(${background})) c(white) ///
			order(2 "100 Largest Districts") ) ///
		xsize(13.33) ysize(7.5) ///
		graphregion(c(${background})) ///
		name(meansestop100, replace)
		

		
	gen meangsCA = meangs if state == "CA"	
	twoway (scatter meangs ses [aw=mnenrol], msym(Oh) mlc(gs9) mlw(vthin) msize(small)) ///
		(scatter meangsCA ses [aw=mnenrol], msym(O) mc(${yellow}) mlc(black) mlw(vvthin) msize(small)) ///
		(function y = `=_b[_cons]' + `=_b[ses]'*x + `=_b[ses2]'*x^2 + `=_b[ses3]'*x^3, ran(-4 3) lc(maroon) lp(dash) lw(thin))  ///
		if abs(meangs)<=5 & abs(ses)<4 ///
		, ///
		title("Academic Achievement and Socioeconomic Status", size(vlarge) color(white)) ///
		subtitle("US School Districts, 2009-2016", size(medlarge) color(white)) ///
		xlab(-4(1)3 ///
			, labsize(small) angle(hori) labc(white) tlcolor(white)) ///
		ysc(titlegap(2)) ///
		xsc(ran(-4 3) lc(white) titlegap(2)) ///
		ylin(0, lc(gs14) lw(vthin) lp(dash)) ///
		ylab(-5(1)4, angle(hori) labsize(small) format(%3.0f) nogrid labc(white)) ///
			ytitle("Average Achievement (Grade Levels)", color(white) size(large)) ///
		xtitle("                     <----- Poor/Disadvantaged ------------------- Affluent/Advantaged ----->", color(white) size(large)) ///
		leg(ring(0) cols(1) pos(4) size(medsmall) region(fc(${background}) lc(${background})) c(white) ///
			order(2 "California Districts") ) ///
		xsize(13.33) ysize(7.5) ///
		graphregion(c(${background})) ///
		name(meansesCA, replace)		
		

		
	*gen meangsCA = meangs if state == "CA"	
	gen meangsMA = meangs if state == "MA"	
	twoway (scatter meangs ses [aw=mnenrol], msym(Oh) mlc(gs9) mlw(vthin) msize(small)) ///
		(scatter meangsMA ses [aw=mnenrol], msym(O) mc(maroon) mlc(black) mlw(vvthin) msize(small)) ///
		(scatter meangsCA ses [aw=mnenrol], msym(O) mc("255 230 153") mlc(black) mlw(vvthin) msize(small)) ///
		(function y = `=_b[_cons]' + `=_b[ses]'*x + `=_b[ses2]'*x^2 + `=_b[ses3]'*x^3, ran(-4 3) lc(maroon) lp(dash) lw(thin)) ///
		if abs(meangs)<=5 & abs(ses)<4 ///
		, ///
		title("Academic Achievement and Socioeconomic Status", size(vlarge) color(white)) ///
		subtitle("US School Districts, 2009-2016", size(medlarge) color(white)) ///
		xlab(-4(1)3 ///
			, labsize(small) angle(hori) labc(white) tlcolor(white)) ///
		ysc(titlegap(2)) ///
		xsc(ran(-4 3) lc(white) titlegap(2)) ///
		ylin(0, lc(gs14) lw(vthin) lp(dash)) ///
		ylab(-5(1)4, angle(hori) labsize(small) format(%3.0f) nogrid labc(white)) ///
			ytitle("Average Achievement (Grade Levels)", color(white) size(large)) ///
		xtitle("                     <----- Poor/Disadvantaged ------------------- Affluent/Advantaged ----->", color(white) size(large)) ///
		leg(ring(0) cols(1) pos(4) size(medsmall) region(fc(${background}) lc(${background})) c(white) ///
			order(3 "California Districts" 2 "Massachusetts Districts") ) ///
		xsize(13.33) ysize(7.5) ///
		graphregion(c(${background})) ///
		name(meansesCAMA, replace)
		

