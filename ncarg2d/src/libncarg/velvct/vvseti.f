C
C       $Id: vvseti.f,v 1.5 2000-08-22 15:07:36 haley Exp $
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
C
C-----------------------------------------------------------------------
C
      SUBROUTINE VVSETI (CNM,IVL)
C
      CHARACTER*(*) CNM
C
C This subroutine is called to give a specified integer value to a
C specified parameter.
C
C CNM is the name of the parameter whose value is to be set.
C
C IVL is an integer variable containing the new value of the parameter.
C
C The real work is done by VVSETR
C
C Float the integer value and pass it on to VVSETR.
C
      RVL=REAL(IVL)
      CALL VVSETR (CNM,RVL)
C
C Done.
C
      RETURN
C
      END
