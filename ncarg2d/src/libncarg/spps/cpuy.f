C
C $Id: cpuy.f,v 1.5 2000-08-22 15:06:08 haley Exp $
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
      FUNCTION CPUY (IY)
C
C Given a Y coordinate IY in the plotter system, CPUY(IY) is a Y
C coordinate in the user system.
C
      COMMON /IUTLCM/ LL,MI,MX,MY,IU(96)
      SAVE /IUTLCM/
      DIMENSION WD(4),VP(4)
      CALL GQCNTN (IE,NT)
      IF (IE.NE.0) THEN
        CALL SETER ('CPUY - ERROR EXIT FROM GQCNTN',1,1)
        CPUY=0.
        RETURN
      END IF
      CALL GQNT (NT,IE,WD,VP)
      IF (IE.NE.0) THEN
        CALL SETER ('CPUY - ERROR EXIT FROM GQNT',2,1)
        CPUY=0.
        RETURN
      END IF
      I=3
      IF (MI.EQ.2.OR.MI.GE.4) I=4
      CPUY=WD(I)+(FLOAT(IY-1)/(2.**MY-1.)-VP(3))/(VP(4)-VP(3))*
     +     (WD(7-I)-WD(I))
      IF (LL.EQ.2.OR.LL.GE.4) CPUY=10.**CPUY
      RETURN
      END
