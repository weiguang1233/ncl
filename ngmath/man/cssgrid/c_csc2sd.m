.\"
.\"	$Id: c_csc2sd.m,v 1.3 2000-08-22 15:14:33 haley Exp $
.\"
.TH c_csc2sd 3NCARG "MAY 2000" UNIX "NCAR GRAPHICS"
.SH NAME
c_csc2sd - convert from Cartesian coordinates to lat/lon coordinates.
.SH FUNCTION PROTOTYPE
.nf
.cs R 24
    void   c_csc2sd(int, double *, double *, double *, double *, double *);
.fi
.cs R
.sp
.SH SYNOPSIS
.nf
.cs R 24
    c_csc2sd(n, x, y, z, rlat, rlon);
.fi
.cs R
.sp
.SH DESCRIPTION
.IP n 12
The number of input Cartesian coordinates.
.IP x 12
An array containing the X component of the Cartesian 
coordinates of the input data. (rlat[i],rlon[i]) is
the lat/lon coordinate corresponding to the Cartesian
coordinate (x[i],y[i],z[i]) for i=0 to n-1. 
.IP y 12
An array containing the Y component of the Cartesian 
coordinates of the input data. (rlat[i],rlon[i]) is
the lat/lon coordinate corresponding to the Cartesian
coordinate (x[i],y[i],z[i]) for i=0 to n-1. 
.IP z 12
An array containing the Z component of the Cartesian 
coordinates of the input data. (rlat[i],rlon[i]) is
the lat/lon coordinate corresponding to the Cartesian
coordinate (x[i],y[i],z[i]) for i=0 to n-1. 
.IP rlat 12
An array containing the latitudes of the output coordinates,
in degrees. 
.IP rlon 12
An array containing the longitudes of the output coordinates,
in degrees. 
.SH USAGE
c_csc2sd is called to find the equivalent lat/lon coordinates
to specified Cartesian coordinates on a unit sphere.
The Cartesian coordinate (1.,0.,0.) is
converted to lat/lon coordinate (0.,0.). Latitudes and 
longitudes are assumed to be in degrees. 
c_csc2sd is a double precision version of c_csc2s.
.SH RETURN VALUE
c_csc2sd does not return a value.
.SH ACCESS
To use c_csc2sd, load the NCAR Graphics library ngmath.
.SH SEE ALSO
css_overview,
c_cssgrid,
c_csc2s.
.sp
Complete documentation for Cssgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/cssgrid/csshome.html
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

