.\"
.\"	$Id: c_shgrid.m,v 1.3 2000-08-22 15:15:15 haley Exp $
.\"
.TH c_shgrid 3NCARG "September 1999" UNIX "NCAR GRAPHICS"
.SH NAME
c_shgrid - interpolate random data in 3-space using a modified Shepard's algorithm
.SH FUNCTION PROTOTYPE
.nf
.cs R 24
float *c_shgrid(int, float [], float [], float [], float [],
                int, int, int, float [], float [], float [], int*);
.fi
.cs R
.sp
.SH SYNOPSIS
.nf
.cs R 24
float *c_shgrid (n, x[], y[], z[], f[], nxo, nyo, nzo, 
                 xo[], yo[], zo[], ier);
.fi
.cs R
.sp
.SH DESCRIPTION
.IP n 12
(integer,input) The number of input data points (n > 9).
.IP xi 12
(float, input) An array dimensioned for n containing the X coordinate 
values for the input function.
.IP yi 12
(float, input) An array dimensioned for n containing the Y coordinate 
values for the input function. 
.IP zi 12
(float, input) An array dimensioned for n containing the Z coordinate 
values for the input function. 
.IP f 12
(float, input) An array containing the functional values of 
the input function -- f[k] is the
functional value at (xi[k], yi[k], zi[k]) for k=0,n-1. 
.IP nxo 12
(integer, input) The number of X coordinate 
values to be calculated for the output grid. 
.IP nyo 12
(integer, input) The number of Y coordinate 
values to be calculated for the output grid. 
.IP nzo 12
The number of Z coordinate values to be calculated for the output grid. 
.IP xo 12
(float, input) An array dimensioned for nxo
containing the X coordinates of the output grid.
.IP yo 12
(float, output) An array dimensioned for nyo
containing the Y coordinates of the output grid.
.IP zo 12
(float, output) An array dimensioned for nzo
containing the Z coordinates of the output grid.
.IP ier 12
(pointer to integer, output) An error return value. 
If *ier is returned as 0, then no errors were 
detected. If *ier is non-zero, then refer to the error list in the error 
table for details. 
.SH USAGE
c_shgrid is called to interpolate randomly spaced data in 3-space. 
c_shgrid uses a modified Shepard's algorithm to construct an 
interpolatory surface. 
.sp
c_shgrid returns a pointer to a linear array of data that is the interpolation
grid stored in row-major order. That is, if out is declared as 

.nf
.cs R 24
  float *out;
.fi
.cs R
.sp
and we set: 

.nf
.cs R 24
  out = c_shgrid(n, x, y, z, f, nxo, nyo, nzo, xo, yo, zo, ier);
.fi
.cs R
.sp
then out[nz*ny*i + nz*j + k] is the approximation function value 
at coordinate point (xo[i],
yo[j], zo[k]) for 0 <= i < nx, 0 <= j < ny, and 0 <= k < nz. The space 
for out is allocated internal to c_shgrid and is nx*ny*nz floats in size. 
.SH ACCESS
To use c_shgrid, load the NCAR Graphics library ngmath.
.SH SEE ALSO
shgrid_params, 
c_shseti, 
c_shgeti, 
c_shgetnp.
.sp
Complete documentation for Shgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/shgrid/shhome.html
.SH COPYRIGHT
Copyright (C) 1997-2000
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

