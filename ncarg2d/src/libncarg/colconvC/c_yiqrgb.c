/*
 *	$Id: c_yiqrgb.c,v 1.4 2000-08-22 15:02:33 haley Exp $
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

extern void NGCALLF(yiqrgb,YIQRGB)(float*,float*,float*,float*,float*,float*);

void c_yiqrgb
#ifdef NeedFuncProto
(
    float y,
    float i,
    float q,
    float *r,
    float *g,
    float *b
)
#else
 ( y, i, q, r, g, b )
    float y;
    float i;
    float q;
    float *r;
    float *g;
    float *b;
#endif
{
    NGCALLF(yiqrgb,YIQRGB)( &y, &i, &q, r, g, b );
}
