.TH MAPGRM 3NCARG "March 1993" UNIX "NCAR GRAPHICS"
.na
.nh
.SH NAME
MAPGRM - 
Draws lines of latitude and longitude masked against an existing area
map. 
.SH SYNOPSIS
CALL MAPGRM (IAMA,XCRA,YCRA,MCRA,IAAI,IAGI,MNOG,ULPR)
.SH C-BINDING SYNOPSIS
#include <ncarg/ncargC.h>
.sp
void c_mapgrm (int *iama, float *xcra, float *ycra, \\
.br
int mcra, int *iaai, int *iagi, int mnog, \\
.br
int (*ulpr)(float *xcra, float *ycra, int *ncs, \\
.br
int *iaai, int *iagi, int *nai))
.SH DESCRIPTION 
.IP IAMA 12 
(an input/output array, dimensioned as specified in a call to the
AREAS routine ARINAM, of type INTEGER) is the array containing the area
map against which lines of latitude and longitude are to be masked. The
area map must have been initialized by a call to ARINAM; it may contain
edges added to it by calling MAPBLA, as is the case in the example named
"eezmpa", or it may contain a different set of edges to create some other
desired effect. For example, an area map might be created that defines a
region of interest, within which user data is available and within which
lines of latitude and longitude are to be drawn. For more details, see
the reference document for the package named AREAS.
.IP "XCRA and YCRA" 12 
(scratch arrays, dimensioned at least MCRA, of type REAL)
are to be used by MAPGRM in calls to the AREAS routine ARDRLN; they will
eventually be used in calls to the user-provided line-processing routine
ULPR.
.IP MCRA 12 
(an input expression of type INTEGER) is the dimension of the arrays
XCRA and YCRA.
.IP "IAAI and IAGI" 12 
(scratch arrays, dimensioned at least NOGI, of type
INTEGER) are to be used by MAPGRM in calls to the AREAS routine ARDRLN;
they will eventually be used in calls to the user-provided
line-processing routine ULPR. The mnemonics stand for "Integer Array of Area
Identifiers" and "Integer Array of Group Identifiers", respectively.
.IP NOGI 12 
(an input expression of type INTEGER) is the dimension of the arrays
IAAI and IAGI. The mnemonic stands for "Number Of Group Identifiers (of
edges in the area map)", which determines the required dimension of IAAI
and IAGI.
.IP ULPR 12 
is the name of the user-supplied line-processing routine. It must be
declared EXTERNAL in the routine that calls MAPGRM, so that the compiler
and loader will know that it is the name of a routine to be called
instead of a variable. The user routine ULPR will be called once for each
piece of a latitude/longitude line resulting from the masking process; it
may decide to draw (or to not draw) each such piece. ULPR will be called
using a FORTRAN statement like
.sp
.RS 17 
CALL ULPR (XCRA,YCRA,NCRA,IAAI,IAGI,NGPS)
.RE 
.IP "" 12 
where XCRA and YCRA are real arrays holding the normalized device
coordinates of NCRA points defining a polyline which is part of some
latitude/longitude line and IAAI and IAGI are integer arrays holding NGPS
area-identifier/group-identifier pairs for the area within which that
piece of the line lies. In writing ULPR, the user may rely upon a SET
call's having been done which makes it possible to use normalized device
coordinates in calls to routines like CURVE, CURVED, GPL, etc. For more
details, see the reference document for the package named AREAS and, in
particular, the description of the subroutine ARDRLN.
.SH C-BINDING DESCRIPTION
The C-binding argument descriptions are the same as the FORTRAN 
argument descriptions.
.SH USAGE@@@
The statement
.RS 5
.sp
CALL MAPGRM (IAMA,XCRA,YCRA,MCRA,IAAI,IAGI,MNOG,ULPR)
.RE
.sp
does the same thing as the statement
.RS 5
.sp
CALL MAPGRD
.RE
.sp
except that the grid lines are drawn using calls to MAPITM and MAPIQM,
which does the masking of the lines against the area map defined by the
arguments in the call and passes the
pieces resulting from the masking process to a user-provided line-drawing
routine.
.SH EXAMPLES
Use the ncargex command to see the following relevant
examples: 
ccppole,
cmpfil,
cmpgrp,
cmpitm,
cmplab,
cmpmsk,
cmptit,
cpex08,
eezmpa,
tezmpa.
.SH ACCESS
To use MAPGRM, load the NCAR Graphics libraries ncarg, ncarg_gks,
ncarg_c, and ncarg_loc, preferably in that order.  To use c_mapgrm, load 
the NCAR Graphics libraries ncargC, ncarg_gksC, ncarg, ncarg_gks,
ncarg_c, and ncarg_loc, preferably in that order.
.SH SEE ALSO
Online:
ezmap, 
ezmap_params, 
mapaci,
mapbla,
mapdrw,
mapeod, 
mapfst,
mapgci,
mapgrd,
mapgtc,  
mapgti,  
mapgtl,  
mapgtr,  
mapint,
mapiq,
mapiqa,
mapiqm,
mapit,
mapita,
mapitm,
maplbl,
maplmb,
maplot,
mappos,   
maproj,  
maprs,
maprst,  
mapsav,  
mapset,  
mapstc,  
mapsti,  
mapstl,  
mapstr,  
maptra,
maptri,
maptrn,
mapusr, 
mapvec,
mpgetc,
mpgeti,  
mpgetl,
mpgetr,  
mpsetc,  
mpseti,  
mpsetl,  
mpsetr,  
supmap,
supcon,
ncarg_cbind
.sp
Hardcopy: 
Tutorial: A Step-by-Step Guide to Contouring and Mapping
.SH COPYRIGHT
Copyright 1987, 1988, 1989, 1991, 1993 University Corporation
for Atmospheric Research
.br
All Rights Reserved
