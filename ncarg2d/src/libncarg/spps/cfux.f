C
C $Id: cfux.f,v 1.5 2000-08-22 15:06:06 haley Exp $
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
      FUNCTION CFUX (RX)
C
C Given an X coordinate RX in the fractional system, CFUX(RX) is an X
C coordinate in the user system.
C
      COMMON /IUTLCM/ LL,MI,MX,MY,IU(96)
      SAVE /IUTLCM/
      DIMENSION WD(4),VP(4)
      CALL GQCNTN (IE,NT)
      IF (IE.NE.0) THEN
        CALL SETER ('CFUX - ERROR EXIT FROM GQCNTN',1,1)
        CFUX=0.
        RETURN
      END IF
      CALL GQNT (NT,IE,WD,VP)
      IF (IE.NE.0) THEN
        CALL SETER ('CFUX - ERROR EXIT FROM GQNT',2,1)
        CFUX=0.
        RETURN
      END IF
      I=1
      IF (MI.GE.3) I=2
      CFUX=WD(I)+(RX-VP(1))/(VP(2)-VP(1))*(WD(3-I)-WD(I))
      IF (LL.GE.3) CFUX=10.**CFUX
      RETURN
      END
