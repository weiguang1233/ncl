/*
 *	$Id: c_stinit.c,v 1.4 2000-08-22 15:06:47 haley Exp $
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

extern void NGCALLF(stinit,STINIT)(float*,int*,float*,int*,float*,int*,
                                   int*,int*,float*,int*);

void c_stinit
#ifdef NeedFuncProto
(
    float *u,
    int lu,
    float *v,
    int lv,
    float *p,
    int lp,
    int m,
    int n,
    float *wrk,
    int lw
)
#else
(u,lu,v,lv,p,lp,m,n,wrk,lw)
    float *u;
    int lu;
    float *v;
    int lv;
    float *p;
    int lp;
    int m;
    int n;
    float *wrk;
    int lw;
#endif
{
    NGCALLF(stinit,STINIT)(u,&lu,v,&lv,p,&lp,&m,&n,wrk,&lw);
}
