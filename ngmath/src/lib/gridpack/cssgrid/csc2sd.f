C
C	$Id: csc2sd.f,v 1.3 2000-08-22 15:19:08 haley Exp $
C                                                                      
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C This file is free software; you can redistribute it and/or modify
C it under the terms of the GNU General Public License as published
C by the Free Software Foundation; either version 2 of the License, or
C (at your option) any later version.
C
C This software is distributed in the hope that it will be useful, but
C WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
C General Public License for more details.
C
C You should have received a copy of the GNU General Public License
C along with this software; if not, write to the Free Software
C Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
C USA.
C
      SUBROUTINE CSC2SD (N,X,Y,Z,RLAT,RLON)
      DOUBLE PRECISION X(N),Y(N),Z(N),RLAT(N),RLON(N)
C
C  This subroutine converts a point P from Cartesian coor-
C  dinates to spherical coordinates.
C
C
C On input:
C
C       X,Y,Z = Cartesian coordinates of P.
C
C On output:
C
C       RLAT = Latitude of P, in degrees. - 90. .LE. RLAT .LE. 90.
C
C       PLON = Longitude of P, in degrees. -180. .LE. RLON .LE. 180.
C
C Modules required by CSC2S:  CSSCOORD
C
C Intrinsic functions called by CSC2S:  None
C
C***********************************************************
C
      PARAMETER (R2D=57.295778D0)
      DOUBLE PRECISION PRNM,RLATD,RLOND
C
      DO 10 I=1,N
        CALL CSSCOORDD(X(I),Y(I),Z(I),RLATD,RLOND,PRNM)
        RLAT(I) = R2D*RLATD
        RLON(I) = R2D*RLOND
   10 CONTINUE
C
      RETURN
      END
