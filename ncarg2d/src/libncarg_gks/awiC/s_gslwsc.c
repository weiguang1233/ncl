/*
 *	$Id: s_gslwsc.c,v 1.4 2000-08-22 15:09:19 haley Exp $
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

/*
 *  Set linewidth scale factor  
 */

#include <ncarg/gks.h>

extern void NGCALLF(gslwsc,GSLWSC)(Gfloat*);

void gset_linewidth
#ifdef NeedFuncProto
(
    Gdouble linewidth  /* linewidth scale factor  */
)
#else
( linewidth )
    Gdouble linewidth;
#endif
{
    Gfloat width;
    width = (Gfloat)linewidth;
    NGCALLF(gslwsc,GSLWSC)(&width);
}
