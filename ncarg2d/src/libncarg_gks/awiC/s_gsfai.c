/*
 *	$Id: s_gsfai.c,v 1.4 2000-08-22 15:09:18 haley Exp $
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
 *  Set fill area index  
 */

#include <ncarg/gks.h>

extern void NGCALLF(gsfai,GSFAI)(Gint*);

void gset_fill_ind
#ifdef NeedFuncProto
(
    Gint fill_ind  /*  fill area index  */
)
#else
( fill_ind )
    Gint fill_ind;
#endif
{
    NGCALLF(gsfai,GSFAI)(&fill_ind);
}
