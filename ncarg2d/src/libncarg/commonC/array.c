/*
 *	$Id: array.c,v 1.3 2000-08-22 15:02:36 haley Exp $
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

void Pad_char_array(str1,str2,n,maxlen)
    char *str1[], *str2;
    int n, maxlen;
{
    int i, j;

    str2[0] = '\0';
    for( i = 0; i < n; i++ ) {
        strncat(str2,str1[i],strlen(str1[i]));
        for( j = strlen(str1[i]); j < maxlen; j++ ) strncat(str2," ",1);
    }
    str2[n*maxlen] = '\0';
}
