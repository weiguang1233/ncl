C
C $Id: sfgetr.f,v 1.6 2000-08-22 15:05:59 haley Exp $
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
      SUBROUTINE SFGETR (CNP,RVP)
C
      CHARACTER*(*) CNP
C
C This subroutine is called to retrieve the real value of a specified
C parameter.
C
C CNP is the name of the parameter whose value is to be retrieved.
C
C RVP is a real variable in which the desired value is to be returned
C by SFGETR.
C
C
C Declare the labeled common block.
C
      COMMON /SFCOMN/ AID,DBL,ITY,LPA,LCH,LDP(8,8)
C
C Declare the block data routine external to force its loading.
C
      EXTERNAL SFBLDA
C
C Declare a local character variable in which to form an error message.
C
      CHARACTER*38 CTM
C
C Check for an uncleared prior error.
C
      IF (ICFELL('SFGETR - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
C
C Check for a parameter name that is too short.
C
      IF (.NOT.(LEN(CNP).LT.2)) GO TO 10001
      CTM(1:36)='SFGETR - PARAMETER NAME TOO SHORT - '
      CTM(37:36+LEN(CNP))=CNP
      CALL SETER (CTM(1:36+LEN(CNP)),2,1)
      RETURN
10001 CONTINUE
C
C Get the appropriate parameter value.
C
      IF (.NOT.(CNP(1:2).EQ.'AN'.OR.CNP(1:2).EQ.'an')) GO TO 10002
      RVP=AID
      GO TO 10003
10002 CONTINUE
      IF (.NOT.(CNP(1:2).EQ.'CH'.OR.CNP(1:2).EQ.'ch')) GO TO 10004
      RVP=REAL(LCH)
      GO TO 10003
10004 CONTINUE
      IF (.NOT.(CNP(1:2).EQ.'DO'.OR.CNP(1:2).EQ.'do')) GO TO 10005
      RVP=REAL(LPA)
      GO TO 10003
10005 CONTINUE
      IF (.NOT.(CNP(1:2).EQ.'SP'.OR.CNP(1:2).EQ.'sp')) GO TO 10006
      RVP=DBL
      GO TO 10003
10006 CONTINUE
      IF (.NOT.(CNP(1:2).EQ.'TY'.OR.CNP(1:2).EQ.'ty')) GO TO 10007
      RVP=REAL(ITY)
      GO TO 10003
10007 CONTINUE
      CTM(1:36)='SFGETR - PARAMETER NAME NOT KNOWN - '
      CTM(37:38)=CNP(1:2)
      CALL SETER (CTM(1:38),3,1)
      RETURN
10003 CONTINUE
C
C Done.
C
      RETURN
C
      END
