/*
 *	$Id: c_cpsetc.c,v 1.4 2000-08-22 15:03:02 haley Exp $
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

extern void NGCALLF(cpsetc,CPSETC)(NGstring,NGstring,int,int);

void c_cpsetc
#ifdef NeedFuncProto
(
    char *whch,
    char *cval
)
#else
( whch, cval )
    char *whch;
    char *cval;
#endif
{
    NGstring whch2;
    NGstring cval2;
    int len1, len2;
/*
 * Make sure parameter name is not NULL
 */
    if( !whch ) { 
        fprintf( stderr, "c_cpsetc:  illegal parameter name (NULL)\n" );
        return;
    }
    len1 = NGSTRLEN(whch);
    len2 = NGSTRLEN(cval);
    whch2 = NGCstrToFstr(whch,len1);
    cval2 = NGCstrToFstr(cval,len2);
    NGCALLF(cpsetc,CPSETC)(whch2,cval2,len1,len2);
}


