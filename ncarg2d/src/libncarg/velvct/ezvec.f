C
C       $Id: ezvec.f,v 1.5 2000-08-22 15:07:31 haley Exp $
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
      SUBROUTINE EZVEC (U,V,M,N)
C
C THIS SUBROUTINE IS FOR THE USER WHO WANTS A QUICK-AND-DIRTY VECTOR
C PLOT WITH DEFAULT VALUES FOR MOST OF THE ARGUMENTS.
C
        SAVE
C
      DIMENSION       U(M,N)     ,V(M,N)     ,SPVAL(2)
C
      DATA FLO,HI,NSET,LENGTH,ISPV,SPVAL(1),SPVAL(2) /
     +      0.,0.,   0,     0,   0,      0.,      0. /
C
      CALL VELVCT (U,M,V,M,M,N,FLO,HI,NSET,LENGTH,ISPV,SPVAL)
      CALL FRAME
      RETURN
      END
