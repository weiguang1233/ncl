.TH MAPSET 3NCARG "March 1993" UNIX "NCAR GRAPHICS"
.na
.nh
.SH NAME
MAPSET - Specifies the rectangular portion of the u/v plane to
be drawn.
.SH SYNOPSIS
CALL MAPSET (JLTS, PLM1, PLM2, PLM3, PLM4)
.SH C-BINDING SYNOPSIS
#include <ncarg/ncargC.h>
.sp
void c_mapset (char *jlts, float *plm1, float *plm2, \\
.br
float *plm3, float *plm4)
.SH DESCRIPTION 
.IP JLTS 12
(an input expression, of type CHARACTER) is a character string
specifying how the limits of the map are to be chosen. There are five
possibilities, as follows:
.sp
.RS 12
.IP \(bu
JLTS='MA' (MAXIMUM). The maximum useful area produced by the projection
is plotted. PLM1, PLM2, PLM3, and PLM4 are not used.
.IP \(bu 
JLTS='CO' (CORNERS). The points (PLM1,PLM2) and (PLM3,PLM4) are to be at
opposite corners of the map. PLM1 and PLM3 are latitudes, in degrees.
PLM2 and PLM4 are longitudes, in degrees. If a cylindrical projection is
being used, the first point should be on the left edge of the map and the
second point on the right edge; otherwise, the order makes no difference.
.IP \(bu
JLTS='PO' (POINTS). PLM1, PLM2, PLM3, and PLM4 are two-element arrays
giving the latitudes and longitudes, in degrees, of four points which are
to be on the edges of the rectangular map. If a cylindrical projection is
being used, the first point should be on the left edge and the second
point on the right edge; otherwise, the order makes no difference.
.IP \(bu
JLTS='AN' (ANGLES). PLM1, PLM2, PLM3, and PLM4 are positive angles, in
degrees, representing angular distances from a point on the map to the
left, right, bottom, and top edges of the map, respectively. For most
projections, these angles are measured with the center of the earth at
the vertex and represent angular distances from the point which projects
to the origin of the u/v plane; on a satellite-view projection, they are
measured with the satellite at the vertex and represent angular
deviations from the line of sight. Angular limits are particularly useful
for polar projections and for the satellite-view projection; they are not
appropriate for the Lambert conformal conic and an error will result if
one attempts to use JLTS='AN' with JPRJ='LC'.
.IP \(bu
JLTS='LI' (LIMITS). PLM1, PLM2, PLM3, and PLM4 specify the minimum value
of u, the maximum value of u, the minimum value of v, and the maximum
value of v, respectively. Knowledge of the projection equations is
necessary in order to use this option correctly.
.RE
.IP "PLM1, PLM2, PLM3, and PLM4" 12 
(input arrays, dimensioned 2, of type REAL)
are as described above, depending on the value of JLTS. Note that each is
a two-element array. Strictly speaking, the FORTRAN standard requires
that they be declared as such, even when only the first element of each
array is used.
.SH C-BINDING DESCRIPTION 
The C-binding argument descriptions are the same as the FORTRAN 
argument descriptions.
.SH USAGE
This routine allows you to set the current values of the
Ezmap parameters 'AR', 'P1', 'P2', ... 'P7', and 'P8'.
For a complete list of parameters available
in this utility, see the ezmap_params man page.
.SH EXAMPLES
Use the ncargex command to see the following relevant
examples: 
ccpcica,
ccpmap,
ccpmovi,
ccppole,
ccpvp,
colcon,
cezmap1,
cezmap2,
cezmap3,
cmpclr,
cmpdd,
cmpdrw,
cmpfil,
cmpgrd,
cmpgrp,
cmpita,
cmpitm,
cmplab,
cmplbl,
cmplot,
cmpmsk,
cmpou,
cmptra,
cpex01,
cpex03,
cpex08,
cpex09,
mpex01,
mpex02,
mpex04,
mpex07,
mpex09,
mpex10,
eezmpa,
tezmap,
tezmpa,
fgkgpl,
fgkgtx,
fngngdts.
.SH ACCESS
To use MAPSET, load the NCAR Graphics libraries ncarg, ncarg_gks,
ncarg_c, and ncarg_loc, preferably in that order.  To use c_mapset, load 
the NCAR Graphics libraries ncargC, ncarg_gksC, ncarg, ncarg_gks, 
ncarg_c, and ncarg_loc, preferably in that order.
.SH MESSAGES
See the ezmap man page for a description of all Ezmap error
messages and/or informational messages.
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
mapgrm,
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
