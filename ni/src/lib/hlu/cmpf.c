/*
 *      $Id: cmpf.c,v
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <ncarg/hlu/hluutil.h>
#include <ncarg/hlu/hlu.h>

float _NhlRndIt
#if	NhlNeedProto
(
	float a,
	int sig_digit
)
#else
(a,sig_digit)
	float a;
	int sig_digit;
#endif
{
	char	func[] = "_NhlRndIt";
        float	tmp;
	char	tstr[20];
	char	*end = NULL;

/*
* if its equal to zero just return
*/
        if(a == 0.0)
                return a;
/*
* floats are only accurate to 7 decimal places when 32bit IEEE used
*/
        if(sig_digit>7)
                sig_digit = 7;

	/*
 	 * Let sprintf round the number for us.
	 */
	sprintf(tstr,"%*.*e",1,sig_digit-1,a);
	tmp = (float)strtod(tstr,&end);

	if(!tmp && (tstr == end)){
		NhlPError(NhlWARNING,NhlEUNKNOWN,"%s:Rounding error!",func);
		return a;
	}

	return tmp;
}

float    _NhlCmpF
#if	NhlNeedProto
(float a, NhlCompareDat *b)
#else
(a,b)
        float a;
        NhlCompareDat *b;
#endif
{
        float   a_final,b_final;
        long a_int,b_int;
        int signa;

	if((a==0.0)&&(!b->is_zero)&&(b->lg_abs <= 0.0)){
		a_int = 0;
		b_final = b->orig_val * (float)pow(10.0,b->sig_dig);
		b_int = (long)b_final;
		return((float)a_int-b_int);
	} else if((a!=0.0)&&(b->is_zero)&&(log10(fabs(a)) <= 0.0)){
		b_int = 0;
		a_final = a * (float)pow(10.0,(double)b->sig_dig);
		a_int = (long)a_final;
		return((float)a_int - b_int);
	} else if((a==0.0)&&(b->is_zero)){
		return(0.0);
	}

	if((a==0.0)||(b->is_zero)) {
		return(a - b->orig_val);
	}
/*
* store sign info and make sure both numbers are positive so log10 can be
* used.
*/
	if(a < 0.0)
		signa = -1;
	else
		signa = 1;
	
        a_final = fabs(a);
/*
* Now divide through by the exponent determined above
*/
        a_final = a_final/(float)pow(10.0,(double)b->exp);

/*
* Since a and possibly b are now shifted to the immediate left of the decimal,
* multipling by pow(10.0,sig_dig), rounding , setting appropriate sign  and
* truncating the decimal produces two integers that can be compared.
*/
        a_final = a_final * pow(10.0,(double)b->sig_dig);
        a_final = _NhlRndIt(a_final,b->sig_dig);
        a_final *= signa;
        a_int = (long)a_final;
        b_int = (long)b->b_final;
        return((float)a_int-(float)b_int);
}

NhlCompareDat *_NhlCmpFSetup
#if	NhlNeedProto
(float val, int sig_dig)
#else
(val,sig_dig)
	float val;
	int sig_dig;
#endif
{
	NhlCompareDat *tmp = (NhlCompareDat*)malloc((unsigned)sizeof(NhlCompareDat));
	float dummy;
	int sign;
	if(val == 0.0) {
		tmp->is_zero = 1;
		tmp->orig_val = 0.0;
		return(tmp);
	}

	tmp->is_zero = 0;	
	tmp->orig_val = val;
	if(sig_dig > 7)  {
		tmp->sig_dig = 7;
	} else {
		tmp->sig_dig = sig_dig;
	}

	if(val < 0.0)
		sign = -1;
	else
		sign = 1;
	tmp->b_final = fabs(val);
	dummy = (float)log10(tmp->b_final);
	tmp->lg_abs = dummy;
	tmp->exp = (long)ceil(log10(tmp->b_final));
	if((float) tmp->exp == dummy) {
		tmp->exp++;
	}
	tmp->b_final = tmp->b_final/(float)pow(10.0,(double)tmp->exp);
	tmp->b_final = tmp->b_final * pow(10.0,(double)tmp->sig_dig);
	tmp->b_final = _NhlRndIt(tmp->b_final,tmp->sig_dig);
	tmp->b_final *= sign;
	return(tmp);
}

/*
 * Function:	_NhlCmpFAny
 *
 * Description: Differs from _NhlCmpF in that there is no need to set up
 *		a structure containing the expected range of the numbers.
 *		
 *
 * In Args:	a	first floating point number
 *		b	second floating point number
 *		sig_dig	<=7 represents number of significant digits to compare.
 *
 * Out Args:	NONE
 *
 * Return Values: 0 if equal, <0 if a<b, and >0 if a>b
 *
 * Side Effects: NONE
 */
float	_NhlCmpFAny
#if	NhlNeedProto
(float a, float b, int sig_dig)
#else
(a,b,sig_dig)
	float a;
	float b;
	int sig_dig;
#endif
{
	float	a_final;
	float	b_final;
	long a_int;
	long b_int;
	int exp;
	int signa;
	int signb;
	float tmp;
/*
* If sig_dig is > 6, a_int and b_int will overflow and cause problems
*/
	if(sig_dig > 7) 
		sig_dig = 7;

/*
* Get ride of easy cases:
* These actually didn't end up being easy since large numbers compared againts
* zero cause a_int and b_int to overflow. So I added the fabs checks to make
* sure that the absolute value of non-zero numbers are at least between 
* 0 and 1.0.
*/
	if((a == 0.0)&&(b!=0.0)&&(log10(fabs(b))<=0.0)) {
		a_int = 0;
		b_final = b * (float)pow(10.0,(double)sig_dig);
		b_int = (long)b_final;
		return((float)(a_int - b_int));
	} else if((a!=0.0)&&(b==0.0)&&(log10(fabs(a))<=0.0)){
		b_int = 0;
		a_final = a * (float)pow(10.0,(double)sig_dig);
		a_int = (long)a_final;
		return((float)(a_int - b_int));
	} else if((a==0.0)&&(b==0.0)){
		return(0.0);
	}
/*
* If I get here and either a or b is zero then than means one of them is
* greater that 1 and one is 0.0
*/
	if((a==0.0)||(b==0.0)) {
		return(a - b);
	}

	
/*
* store sign info and make sure both numbers are positive so log10 can be
* used. 
*/
	if(a < 0.0)
		signa = -1;
	else
		signa = 1;
	if(b < 0.0)
		signb = -1;
	else
		signb = 1;
	a_final = fabs(a);
	b_final = fabs(b);
/*
* Now compute the exponent needed to shift a to the decimal position immediately
* right of the decimal point for the value of a
*/
	if(a_final>b_final){ 
		tmp = (float)log10(a_final);
		exp = (long)ceil(log10(a_final));
		if((float)exp == tmp)
			exp++;
	} else {
		tmp = (float)log10(b_final);
		exp = (long)ceil(log10(b_final));
		if((float)exp == tmp)
			exp++;
	}

/*
* Now divide through by the exponent determined above
*/
	a_final = a_final/(float)pow(10.0,(double)exp);
	b_final = b_final/(float)pow(10.0,(double)exp);

/*
* Since a and possibly b are now shifted to the immediate left of the decimal,
* multipling by pow(10.0,sig_dig), rounding , setting appropriate sign  and 
* truncating the decimal produces two integers that can be compared.
*/
	a_final = a_final * pow(10.0,(double)sig_dig);
	b_final = b_final * pow(10.0,(double)sig_dig);
	a_final = _NhlRndIt(a_final,sig_dig);
	b_final = _NhlRndIt(b_final,sig_dig);
	a_final *= signa;
	b_final *= signb;
	a_int = (long)a_final;
	b_int = (long)b_final;
	return((float)a_int-(float)b_int);
}

double _NhlCmpDAny
#if	NhlNeedProto
(double a, double b, int sig_dig)
#else
(a,b,sig_dig)
	double a;
	double b;
	int sig_dig;
#endif
{
	double a_final;
	double b_final;
	long a_int;
	long b_int;
	int exp;
	int signa;
	int signb;
	double tmp;
/*
* If sig_dig is > 6, a_int and b_int will overflow and cause problems
*/
	if(sig_dig > 7) 
		sig_dig = 7;

/*
* Get ride of easy cases:
* These actually didn't end up being easy since large numbers compared againts
* zero cause a_int and b_int to overflow. So I added the fabs checks to make
* sure that the absolute value of non-zero numbers are at least between 
* 0 and 1.0.
*/
	if((a == 0.0)&&(b!=0.0)&&(log10(fabs(b))<=0.0)) {
		a_int = 0;
		b_final = b * (double)pow(10.0,(double)sig_dig);
		b_int = (long)b_final;
		return((double)(a_int - b_int));
	} else if((a!=0.0)&&(b==0.0)&&(log10(fabs(a))<=0.0)){
		b_int = 0;
		a_final = a * (double)pow(10.0,(double)sig_dig);
		a_int = (long)a_final;
		return((double)(a_int - b_int));
	} else if((a==0.0)&&(b==0.0)){
		return(0.0);
	}
/*
* If I get here and either a or b is zero then than means one of them is
* greater that 1 and one is 0.0
*/
	if((a==0.0)||(b==0.0)) {
		return(a - b);
	}

	
/*
* store sign info and make sure both numbers are positive so log10 can be
* used. 
*/
	if(a < 0.0)
		signa = -1;
	else
		signa = 1;
	if(b < 0.0)
		signb = -1;
	else
		signb = 1;
	a_final = fabs(a);
	b_final = fabs(b);
/*
* Now compute the exponent needed to shift a to the decimal position immediately
* right of the decimal point for the value of a
*/
	if(a_final>b_final){ 
		tmp = (double)log10(a_final);
		exp = (long)ceil(log10(a_final));
		if((double)exp == tmp)
			exp++;
	} else {
		tmp = (double)log10(b_final);
		exp = (long)ceil(log10(b_final));
		if((double)exp == tmp)
			exp++;
	}

/*
* Now divide through by the exponent determined above
*/
	a_final = a_final/(double)pow(10.0,(double)exp);
	b_final = b_final/(double)pow(10.0,(double)exp);

/*
* Since a and possibly b are now shifted to the immediate left of the decimal,
* multipling by pow(10.0,sig_dig), rounding , setting appropriate sign  and 
* truncating the decimal produces two integers that can be compared.
*/
	a_final = a_final * pow(10.0,(double)sig_dig);
	b_final = b_final * pow(10.0,(double)sig_dig);
	a_final = _NhlRndIt(a_final,sig_dig);
	b_final = _NhlRndIt(b_final,sig_dig);
	a_final *= signa;
	b_final *= signb;
	a_int = (long)a_final;
	b_int = (long)b_final;
	return((double)a_int-(double)b_int);
}
