/*
 *	$Id: c_fagovrvw.c.sed,v 1.1 1994-07-18 15:25:08 haley Exp $
 */
#include <stdio.h>
#include <math.h>

#include <ncarg/ncargC.h>
#include <ncarg/gks.h>

#define WSTYPE SED_WSTYPE
#define WKID   1

#define NPTS  200
#define NCURVE  4

main()
{
	float ydra[NCURVE][NPTS],xdra[NPTS];
	int i, j;
	extern void defclr();

	for( i = 1; i <= NPTS; i++ ) {
        xdra[i-1] = i*0.1;
        for( j = 1; j <= NCURVE; j++ ) {
            ydra[j-1][i-1] = sin(xdra[i-1]+0.2*j)*exp(-0.01*xdra[i-1]*j*j);
		}
	}
/*
 *  Open GKS, open and activate a workstation.
 */
	gopen_gks ("stdout",0);
	gopen_ws (WKID, NULL, WSTYPE);
	gactivate_ws(WKID);

	defclr();


	c_agseti("DASH/SELECTOR.",-1);

	c_agsetc("LABEL/NAME.","B");
	c_agseti("LINE/NUMBER.",-100);
	c_agsetc("LINE/TEXT.","TIME (SECONDS)$");

	c_agsetc("LABEL/NAME.","L");
	c_agseti("LINE/NUMBER.",100);
	c_agsetc("LINE/TEXT.","POSITION (METERS)$");

	c_agsetf("Y/MINIMUM.",-1.4);
	c_agsetf("Y/MAXIMUM.", 1.4);
	c_agsetf("Y/NICE.",    0.0);

	c_ezmxy (xdra,&ydra[0][0],NPTS,NCURVE,NPTS,"X-Y PLOT CAPABILITIES$");

/*
 *  Deactivate and close the workstation, close GKS.
 */
	gdeactivate_ws (WKID);
	gclose_ws (WKID);
	gclose_gks();
}


void defclr()
{
	Gcolr_rep rgb;

	rgb.rgb.red = 0.0; rgb.rgb.green = 0.0; rgb.rgb.blue = 0.0;
	gset_colr_rep(WKID, 0, &rgb);
	rgb.rgb.red = 1.0; rgb.rgb.green = 1.0; rgb.rgb.blue = 1.0;
	gset_colr_rep(WKID, 1, &rgb);
	rgb.rgb.red = 1.0; rgb.rgb.green = 0.0; rgb.rgb.blue = 0.0;
	gset_colr_rep(WKID, 2, &rgb);
	rgb.rgb.red = 0.0; rgb.rgb.green = 1.0; rgb.rgb.blue = 0.0;
	gset_colr_rep(WKID, 3, &rgb);
	rgb.rgb.red = 0.4; rgb.rgb.green = 0.7; rgb.rgb.blue = 0.9;
	gset_colr_rep(WKID, 4, &rgb);
	rgb.rgb.red = 0.7; rgb.rgb.green = 0.4; rgb.rgb.blue = 0.7;
	gset_colr_rep(WKID, 5, &rgb);
	rgb.rgb.red = 0.9; rgb.rgb.green = 0.7; rgb.rgb.blue = 0.4;
	gset_colr_rep(WKID, 6, &rgb);
	rgb.rgb.red = 0.4; rgb.rgb.green = 0.9; rgb.rgb.blue = 0.7;
	gset_colr_rep(WKID, 7, &rgb);
	return;
}

void agchax_(iflg,iaxs,iprt,vils)
int *iflg, *iaxs, *iprt;
float *vils;
{
	c_plotif (0.,0.,2);
	if (*iflg == 0) {
        gset_line_colr_ind( 2 );
        gset_text_colr_ind( 3 );
	}
	else {
        gset_line_colr_ind( 1 );
        gset_text_colr_ind( 1 );
	}
	return;
}

void agchcu_(iflg,kdsh)
int *iflg, *kdsh;
{
	extern int abs();

    c_plotif (0.,0.,2);
    if (*iflg == 0 ) {
        gset_line_colr_ind( abs(*kdsh)+3 );
        gset_text_colr_ind( abs(*kdsh)+3 );
    }
    else {
        gset_line_colr_ind(1);
        gset_text_colr_ind(1);
    }
    return;
}

void agchil_(iflg,lbnm,lnno)
int *iflg, *lnno;
char *lbnm;
{
    c_plotif (0.,0.,2);
    if (*iflg == 0) {
        gset_text_colr_ind( 4 );
    }
    else {
        gset_text_colr_ind( 1 );
    }
    return;
}
