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

#include <stdlib.h>
#include "dstypes.h"
#include "dsproto.h"
#include "dsuhead.h"

/*
 *  Interpolate randomly-spaced 2D input data to a regularly spaced grid.
 *  Single precision version.
 */
float *c_dsgrid2s(int n, float x[], float y[], float u[],
                  int nx, int ny, float xo[], float yo[], int *ier)
{
  float zo[1] = {0.}, *z, *retval, perror = 1.;
  
  z = (float *) calloc(n, sizeof(float));
  if (z == NULL) {
    DSErrorHnd(13, "c_dsgrid2s", ds_filee, "\n");
    *ier = ds_error_status;
    return(&perror);
  }

  retval = c_dsgrid3s(n, x, y, z, u, nx, ny, 1, xo, yo, zo, ier);

  free(z);
  return(retval);
}
void c_dspnt2s(int n, float xi[], float yi[], float zi[],
               int m, float xo[], float yo[], float zo[], int *ier)
{
  int    i;
  float  xt[1], yt[1];

  for (i = 0; i < m; i++) {
    xt[0] = xo[i];
    yt[0] = yo[i];
    zo[i] = *c_dsgrid2s(n, xi, yi, zi, 1, 1, xt, yt, ier);
  }
}
