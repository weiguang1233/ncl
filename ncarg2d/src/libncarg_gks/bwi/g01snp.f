C
C	$Id: g01snp.f,v 1.7 2000-08-22 15:09:38 haley Exp $
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
      SUBROUTINE G01SNP (ERROR)
C
C  Start new picture.
C
      INTEGER ERROR
      INTEGER  G01PBL, HOLD(3), NBYTES, ITMP(4)
C
      include 'g01prm.h'
      include 'g01io.h'
      include 'g01opc.h'
      include 'g01ins.h'
      include 'g01wsl.h'
      include 'gksenu.h'
C
C  Set 'NEW FRAME' flag.
C
      MNFFLG = GYES
C
C  Put out 'BEGIN PICTURE' element using the picture name in MPNAME.
C
      CALL GPUTNI (CLBEGP, IDBEGP, G01PBL(60,0), ERROR)
      CALL GPUTPS (MPNAME(1:60), 60, 60, 0, ERROR)
C
C  Reset picture name to blank.
C
      MPNAME = ' '
      IF (ERROR.NE.0)  GO TO 77
C
C  Put out the PICTURE DESCRIPTOR.
C
C  Put out background color, conditionally depending upon
C  whether it has been explicitly changed.
C
      IF (MBCCHG .EQ. GYES)  THEN
         NBYTES = 1 + (3*MDCCFW-1)/8
         CALL GPUTNI (CLBKGC, IDBKGC, NBYTES, ERROR)
         HOLD(1) = SRED(1)*MDCCRG
         HOLD(2) = SGREEN(1)*MDCCRG
         HOLD(3) = SBLUE(1)*MDCCRG
         CALL GPUTPR (HOLD, MDCCFW, 3, ERROR)
         IF (ERROR.NE.0)  GOTO 77
      ENDIF
C
C  Put out 'BEGIN PICTURE BODY' element.
C
      CALL GPUTNI (CLBGPB, IDBGPB, 0, ERROR)
      IF (ERROR.NE.0)  GO TO 77
C
 77   CONTINUE
C
C  Put out the clipping indicator and rectangle.
C
       CALL G01CLP(1)
C
C  Send the color table.
C
      NBYTES = 1 + (3*MDCCFW + MCIXFW - 1)/8
      DO 10 I=1,MOL
C
C  Put out opcode (CLASS and ID) and length.
C
        CALL GPUTNI (CLCTBL, IDCTBL, NBYTES, RERR)
        IF (RERR.NE.0)  GO TO 77
C
C  Put out parameter index (DATA, PRECIS, COUNT)
C
        CALL GPUTPR (MCOLI(I), MCIXFW, 1, RERR)
        IF (RERR.NE.0)  GO TO 77
C
C  Put out the color components.
C
        ITMP(1) = SRED(I)*REAL(MDCCRG)
        ITMP(2) = SGREEN(I)*REAL(MDCCRG)
        ITMP(3) = SBLUE(I)*REAL(MDCCRG)
        CALL GPUTPR (ITMP, MDCCFW, 3, RERR)
   10 CONTINUE
C
      RETURN
      END
