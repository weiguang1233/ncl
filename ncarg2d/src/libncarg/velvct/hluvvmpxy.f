C
C       $Id: hluvvmpxy.f,v 1.4 2000-08-22 15:07:32 haley Exp $
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
      SUBROUTINE HLUVVMPXY (X,Y,U,V,UVM,XB,YB,XE,YE,IST)
C
C This routine stands between Vectors and the user call-back routine
C VVMPXY.  When HLUs are not in use, this version of the routine gets
C loaded, so that VVMPXY is called.  When HLUs are in use, another
C version gets loaded; it either does the appropriate thing for the
C purposes of the HLUs or calls VVMPXY.
C
      CALL VVMPXY (X,Y,U,V,UVM,XB,YB,XE,YE,IST)
C
      RETURN
C
      END
