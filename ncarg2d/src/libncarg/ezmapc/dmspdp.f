C
C $Id: dmspdp.f,v 1.3 2000-08-22 15:04:09 haley Exp $
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
      DOUBLE PRECISION FUNCTION DMSPDP (SGNA,DEGS,MINS,SECS)
C
C FUNCTION TO CONVERT UNPACKED DMS TO PACKED DMS ANGLE
C SGNA : SIGN OF ANGLE
C DEGS : DEGREES PORTION OF ANGLE
C MINS : MINUTES PORTION OF ANGLE
C SECS : SECONDS PORTION OF ANGLE
C
      IMPLICIT DOUBLE PRECISION (A-Z)
      REAL SECS
      INTEGER DEGS,MINS
      CHARACTER*1 SGNA,NEG
      DATA CON1,CON2 /1000000.0D0,1000.0D0/
      DATA NEG /'-'/
C
      CON = DEGS * CON1 + MINS * CON2 + SECS
      IF (SGNA .EQ. NEG) CON = - CON
      DMSPDP = CON
      RETURN
C
      END
