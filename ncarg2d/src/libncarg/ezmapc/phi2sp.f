C
C $Id: phi2sp.f,v 1.3 2000-08-22 15:04:16 haley Exp $
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
      REAL FUNCTION PHI2SP (ECCENT,TS)
C
C FUNCTION TO COMPUTE LATITUDE ANGLE (PHI-2).
C
      IMPLICIT REAL (A-Z)
      INTEGER II,NIT
      COMMON /ERRMZ0/ IERR
        INTEGER IERR
      SAVE   /ERRMZ0/
      COMMON /PRINZ0/ IPEMSG,IPELUN,IPPARM,IPPLUN
        INTEGER IPEMSG,IPELUN,IPPARM,IPPLUN
      SAVE   /PRINZ0/
      DATA HALF,ONE,TWO /0.5E0,1.0E0,2.0E0/
      DATA TOL,NIT /1.0E-10,15/
      DATA HALFPI /1.5707963267948966E0/
C
      ECCNTH = HALF * ECCENT
      PHI = HALFPI - TWO * ATAN (TS)
      DO 020 II = 1,NIT
      SINPI = SIN (PHI)
      CON = ECCENT * SINPI
      DPHI = HALFPI - TWO * ATAN (TS * ((ONE - CON) /
     .       (ONE + CON)) ** ECCNTH) - PHI
      PHI = PHI + DPHI
      IF (ABS(DPHI) .GT. TOL) GO TO 020
      PHI2SP = PHI
      RETURN
  020 CONTINUE
C
      IF (IPEMSG .EQ. 0) WRITE (IPELUN,2000) NIT,ECCENT,TS
 2000 FORMAT (/' ERROR PHI2SP' /
     .         ' LATITUDE FAILED TO CONVERGE AFTER',I3,' ITERATIONS'/
     .         ' ECCENTRICITY =',E25.16,'   TS =',E25.16)
      IERR = 002
      RETURN
C
      END
