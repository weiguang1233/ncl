.\"
.\"     $Id: c_dsgrid3s.m,v 1.4 2000-08-22 15:14:41 haley Exp $
.\"
.TH c_dsgrid3s 3NCARG "September 1997-1998" UNIX "NCAR GRAPHICS"
.SH NAME
c_dsgrid3s - primary single precision C entry for 3D gridding
.SH FUNCTION PROTOTYPE
.nf
.cs R 24
float  *c_dsgrid3s(int, float [], float [], float [], float [],
.br
          int, int, int, float [], float [], float [], int *);
.fi
.cs R
.br
.SH SYNOPSIS
.nf
.cs R 24
float  *c_dsgrid3s(int n, float x[], float y[], float z[], 
.br
          float u[], int nx, int ny, int nz, float xo[], 
.br
          float yo[], float zo[], int *ier);
.fi
.cs R
.SH DESCRIPTION
.IP n 12
The number of input data points.
.IP x 12
An array containing the X coordinates of the input data 
points.
.IP y 12
An array containing the Y coordinates of the input data 
points.
.IP z 12
An array containing the Z coordinates of the input data 
points.
.IP u 12
An array of size n containing the functional values of the input 
data points. That is, z[m] is the value of the
input function at coordinate (x[m],y[m],z[m]), for 0 <= m < n. 
.IP nx 12
The number of X values in the output grid.
.IP ny 12
The number of Y values in the output grid.
.IP nz 12
The number of Z values in the output grid.
.IP xo 12
An array of size nx containing the X coordinates of the 
output data grid. The values in xo must be
increasing, but need not be equally spaced. 
.IP yo 12
An array of size ny containing the Y 
coordinates of the output data grid. The values in yo must be 
increasing, but need not be equally spaced. 
.IP zo 12
An array of size nz containing the Z 
coordinates of the output data grid. The values in zo must be 
increasing, but need not be equally spaced. 
.IP ier 12
An error return value. If *ier is returned as 0, then no errors 
were detected. If *ier is non-zero, then refer to
the man page for dsgrid_errors.
.SH USAGE
c_dsgrid3s returns a pointer to a linear array of data that is 
the interpolated grid stored in row-major order. That is,
if out is declared as 
.sp
float *out;
.sp
and we set: 
.sp
.nf
.cs R 24
  out = *c_dsgrid3s(n, x, y, z, u, nx, ny, nz, 
.br
            xo, yo, zo, ier);
.fi
.cs R
.sp
then out[nz*ny*i + nz*j + k] is the interpolated function value at 
coordinate point (xo[i],yo[j],zo[k]) for 0 <= i < nx, 
0 <= j < ny, and 0 <= k < nz. The space for out is 
allocated internal to c_dsgrid3s and is nx*ny*nz floats in size. 
.SH ACCESS
To use c_dsgrid3s, load the NCAR Graphics library ngmath.
.SH SEE ALSO
dsgrid,
dsgrid_params, 
c_dsseti, 
c_dsgeti, 
c_dssetr, 
c_dsgetr, 
c_dssetc, 
c_dsgetc.
.sp
Complete documentation for Dsgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/dsgrid/dshome.html
.SH COPYRIGHT
Copyright (C) 2000
.br
University Corporation for Atmospheric Research
.br

This documentation is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as published
by the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This software is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this software; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA.

