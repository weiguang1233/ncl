C
C $Id: bcgeti.f,v 1.3 2000-08-22 15:06:50 haley Exp $
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
      SUBROUTINE BCGETI(PA,IVAL)
C
C Retrieve integer-valued parameters for the Bezier curve package.
C
C Arguments
C     Input
C             PA       Character string indicating parameter.
C
C     Output
C             IVAL     An integer value giving the current setting
C                      of the specified parameter.
C

      CHARACTER*(*) PA
      CHARACTER*3   CTMP
C
      include 'bccom.h'
C
      CTMP = PA(1:3)
C
      IF (CTMP.EQ.'NPC' .OR. CTMP.EQ.'npc') THEN
C
C  Get flag indicating the number of points per curve.
C
        IVAL = NPPC
      ELSE
        WRITE(I1MACH(4),500) CTMP
      ENDIF
C
      RETURN
C
  500 FORMAT(' NTGETI -- Invalid keyword = ',A3,', no action taken')
C
      END
