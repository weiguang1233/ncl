.\"
.\"	$Id: c_ftgetc.m,v 1.3 2000-08-22 15:14:48 haley Exp $
.\"
.TH c_ftgetc 3NCARG "March 1998" UNIX "NCAR GRAPHICS"
.SH NAME
c_ftgetc - retrieve a string valued parameter
.SH FUNCTION PROTOTYPE
void c_ftgetc(char *, char *);
.SH SYNOPSIS
void c_ftgetc (pnam, cval);
.SH DESCRIPTION
.IP pnam 12
The name of the control parameter whose value is to be retrieved. 
.IP cval 12
cval will point to a string containing the returned value. The user 
is required to reserve enough space to store the string. 
.SH USAGE
c_ftgetc is a called to obtain current values for any of the 
string valued control parameters.
.SH ACCESS
To use c_ftgetc, load the NCAR Graphics library ngmath.
.SH SEE ALSO
fitgrid_params, c_ftsetc
.sp
Complete documentation for Fitgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/fitgrid/fithome.html
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

