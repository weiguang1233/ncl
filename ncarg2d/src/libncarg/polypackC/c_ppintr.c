/*
 *	$Id: c_ppintr.c,v 1.4 2000-08-22 15:05:40 haley Exp $
 */
/************************************************************************
*                                                                       *
*                Copyright (C)  2000                                    *
*        University Corporation for Atmospheric Research                *
*                All Rights Reserved                                    *
*                                                                       *
* This file is free software; you can redistribute it and/or modify     *
* it under the terms of the GNU General Public License as published     *
* by the Free Software Foundation; either version 2 of the License, or  *
* (at your option) any later version.                                   *
*                                                                       *
* This software is distributed in the hope that it will be useful, but  *
* WITHOUT ANY WARRANTY; without even the implied warranty of            *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
* General Public License for more details.                              *
*                                                                       *
* You should have received a copy of the GNU General Public License     *
* along with this software; if not, write to the Free Software         *
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307   *
* USA.                                                                  *
*                                                                       *
************************************************************************/

#include <ncarg/ncargC.h>

extern void NGCALLF(ppintr,PPINTR)(float*,float*,int*,float*,float*,int*,
                                   float*,int*,int*,int (*urpt_)(),int*);

void c_ppintr
#ifdef NeedFuncProto
(
	float *xccp,
	float *yccp,
	int nccp,
	float *xcsp,
	float *ycsp,
	int ncsp,
	float *rwrk,
	int *iwrk,
	int nwrk,
    int (*urpt_)(
        float *xcbl,
        float *xcbr,
        float *ycob,
        float *dxle,
        float *dxre,
		float *ycot
               ),
	int *ierr
)
#else
(xccp,yccp,nccp,xcsp,ycsp,ncsp,rwrk,iwrk,nwrk,urpt_,ierr)
	float *xccp;
	float *yccp;
	int nccp;
	float *xcsp;
	float *ycsp;
	int ncsp;
	float *rwrk;
	int *iwrk;
	int nwrk;
	int (*urpt_)();
	int *ierr;
#endif
{
    NGCALLF(ppintr,PPINTR)(xccp,yccp,&nccp,xcsp,ycsp,&ncsp,rwrk,iwrk,&nwrk,
                           urpt_,ierr);
}
