C
C $Id: pwrx.f,v 1.4 2000-08-22 15:05:45 haley Exp $
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
      SUBROUTINE PWRX (X,Y,ID,N,SIZE,THETA,ICNT)
C
C PWRX IS AN OLD ENTRY POINT AND HAS BEEN REMOVED - USE PLOTCHAR
C
      WRITE (I1MACH(4),1001)
      WRITE (I1MACH(4),1002)
      STOP
C
 1001 FORMAT ('1'//////////)
 1002 FORMAT (' ****************************************'/
     1        ' *                                      *'/
     2        ' *                                      *'/
     3        ' *   THE ENTRY POINT PWRX IS NO LONGER  *'/
     4        ' *   SUPPORTED.  PLEASE USE PLOTCHAR.   *'/
     5        ' *                                      *'/
     6        ' *                                      *'/
     7        ' ****************************************')
      END
