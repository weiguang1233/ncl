C
C $Id: agsetf.f,v 1.4 2000-08-22 15:02:17 haley Exp $
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
      SUBROUTINE AGSETF (TPID,FUSR)
C
      CHARACTER*(*) TPID
      DIMENSION FURA(1)
C
C The routine AGSETF may be used to set the real (floating-point) value
C of any single AUTOGRAPH control parameter.
C
      FURA(1)=FUSR
      CALL AGSETP (TPID,FURA,1)
      RETURN
C
      END
