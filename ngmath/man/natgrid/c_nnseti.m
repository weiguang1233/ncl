.\"
.\"     $Id: c_nnseti.m,v 1.1 1997-03-07 22:59:03 fred Exp $
.\"
.TH c_nnseti 3NCARG "March 1997" UNIX "NCAR GRAPHICS"
.SH NAME
c_nnseti - set int valued parameters
.SH FUNCTION PROTOTYPE
void c_nnseti(char *, int);
.SH SYNOPSIS
void c_nnseti (pnam, ival);
.SH DESCRIPTION
.IP pnam 12
A string that specifies the name of the
parameter to be set.
.IP ival 12
An int value to be assigned to the
internal parameter specified by pnam.
.SH USAGE
This routine allows you to set the current value of
Natgrid parameters.  For a complete list of parameters available
in this utility, see the natgrid_params man page.
.SH ACCESS
To use c_nnseti, load the NCAR Graphics library ngmath.
.SH SEE ALSO
natgrid,
natgrid_params,
c_natgrids,
c_nngeti.
.sp
Complete documentation for Natgird is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/natgrid/nnhome.html
.SH COPYRIGHT
Copyright (C) 1997
.br
University Corporation for Atmospheric Research
.br
The use of this Software is governed by a License Agreement.


