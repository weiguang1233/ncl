C
C	$Id: conssd.f,v 1.3 2000-08-22 15:02:41 haley Exp $
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
      SUBROUTINE CONSSD(X,Y,IC)
C
C  THIS SUBROUTINE SETS THE SHIELDING FLAG AND CONNECTS THE
C  USERS SHIELD ARRAYS TO SOME INTERNAL POINTERS
C
C  INPUT
C       X-X COORDINATE STRING
C       Y-Y COORDINATE STRING
C       IC-NUMBER OF COORDINATES
C
C  NOTE THE USERS ARRAYS CANNOT BE MUCKED WITH DURING EXECUTION
C       THOSE ARRAYS ARE USED DURING CONRAN EXECUTION
C
      DIMENSION X(1),Y(1)
      COMMON /CONR13/XVS(50),YVS(50),ICOUNT,SPVAL,SHIELD,
     1               SLDPLT
      LOGICAL SHIELD,SLDPLT
C
        SAVE
C
C  SET COUNTER
C
      ICOUNT = IC
C
C  CHECK THE DIMENSION OF SHIELD ARRAYS
C
      IERUNT = I1MACH(4)
      IF (ICOUNT .GT. 50) THEN
        CALL SETER (' CONSSD -- NUMBER OF SHIELD POINTS .GT. 50',1,1)
        WRITE(IERUNT,1001)
        ICOUNT = 50
      ENDIF
 1001 FORMAT(' ERROR 1 IN CONSSD -- NUMBER OF SHIELD POINTS .GT. 50')
C
C  SET THE SHIELDING FLAG TO TRUE
C
      SHIELD = .TRUE.
C
C  COMPUTE POINTERS FOR THE USERS SHIELDING ARRAYS
C
      DO 300 I = 1,ICOUNT
        XVS(I) = X(I)
 300  YVS(I) = Y(I)
C
      RETURN
      END
