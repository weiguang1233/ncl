/*
 *	$Id: c_msceez.c,v 1.4 2000-08-22 15:07:02 haley Exp $
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

extern void NGCALLF(msceez,MSCEEZ)(float*,float*,float*,float*,float*,
                                   float*,int*);

void c_msceez 
#ifdef NeedFuncProto
(
    float del1,
    float del2,
    float sigma,
    float *c1,
    float *c2,
    float *c3,
    int n
)
#else
(del1,del2,sigma,c1,c2,c3,n)
    float del1;
    float del2;
    float sigma;
    float *c1;
    float *c2;
    float *c3;
    int n;
#endif
{
    NGCALLF(msceez,MSCEEZ)(&del1,&del2,&sigma,c1,c2,c3,&n);
}
