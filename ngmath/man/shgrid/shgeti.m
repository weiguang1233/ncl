.\"
.\"     $Id: shgeti.m,v 1.3 2000-08-22 15:15:16 haley Exp $
.\"
.TH SHGETI 3NCARG "September 1999" UNIX "NCAR GRAPHICS"
.na
.nh
.SH NAME
SHGETI - Retrieves the value of an internal parameter of type
INTEGER.
.SH SYNOPSIS
CALL SHGETI (PNAM,IVAL)
.SH DESCRIPTION 
.IP PNAM 12
A character string that specifies the name of the
parameter to get. The name must appear as the first three
characters of the string.
.IP IVAL 12
An INTEGER variable that is the name of the variable
into which the value of the internal parameter specified by PNAM
is to be retrieved.
.SH USAGE
This routine allows you to retrieve the current value of
Shgrid parameters.  For a complete list of parameters available
in this utility, see the shgrid_params man page.
.SH ACCESS
To use SHGETI, load the NCAR Graphics library ngmath.
.SH SEE ALSO
shgrid,
shgrid_params,
shseti,
shgetnp.
.sp
Complete documentation for Shgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/shgrid/shhome.html
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

