.\"
.\"	$Id: rassplit.m,v 1.11 2000-08-22 15:00:56 haley Exp $
.\"
.TH RASSPLIT 1NCARG "January 1993" NCARG "NCAR VIEW"
.SH \fBNAME\fP
rassplit \- split a multi-frame rasterfile into single-frame rasterfiles.
.SH \fBSYNOPSIS\fP
\fBrassplit\fP 
[\fB\-f f1 f2 f3 ...\fR]
[\fB\-ofmt output-format\fR]
[\fB\-verbose\fR]
[\fB\-Version\fR]
\fIrasterfile\fP
.SH \fBDESCRIPTION\fP
.sp
The program \fBrassplit\fP will open \fIrasterfile\fP and copy each frame
to it's own separate output file. By default, all frames are
extracted but the user can optionally request a specific
set of frames using the \fB-f\fP option. The output format
defaults to be the same as the input format, but the user can
also optionally select a new output format using the \fB-ofmt\fP option.
.sp
The names of the output rasterfiles are derived from the name
of the source rasterfile, the output format, and
the frame numbers. The examples given below will demonstrate
this.
.SH \fBOPTIONS\fP
.TP
.BI \-f " f1 f2 f3 ..."
This option allows the user to specify a list of frames
to be extracted from the input rasterfile.
.TP
.BI \-ofmt " output-format"
The user can specify \fIoutput-format\fP to be the desired format e.g.
\fBhdf\fP, \fBrgb\fP, etc.
.TP
.BI \-help
Print help information.
.TP
.BI \-verbose
Print a message each time an output rasterfile is written.
.TP
.BI \-Version
Print the version number.
.sp
.SH \fBEXAMPLES\fP
.LP
Assume you have a file called 'temp.nrif' that has three frames and
that you'd like to split it into three separate frames, also in NRIF
format.
.LP
.in +1.0i
.nf
rassplit temp.nrif
.fi
.in -1.0i
.LP
This will result in three output files named temp.0001.nrif,
temp.0002.nrif, and temp.003.nrif.
.LP
Assume you only want frames two and three, and you want them produced
in HDF format instead of NRIF.
.LP
.in +1.0i
.nf
rassplit -fmt hdf -f 2 3 temp.nrif
.fi
.in -1.0i
.LP
This will result in two output files named temp.0001.hdf and
temp.0002.hdf.
.sp
.SH \fBCAVEATS\fP
If you're splitting an HDF file, ask for a non-HDF output
format. Otherwise you'll just get the first frame over and
over again.
.sp
.SH "\fBSEE ALSO\fP"
.LP
\fBrasview\fP(1NCARG),\fBrascat\fP(1NCARG),\fBrasls\fP(1NCARG),
\fBrasgetpal\fP(1NCARG),\fBras_formats\fP(5NCARG),\fBras_palette\fP(5NCARG)
.sp
Hardcopy:
NCAR Graphics Fundamentals, UNIX Version
.SH COPYRIGHT
Copyright (C) 1987-2000
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

