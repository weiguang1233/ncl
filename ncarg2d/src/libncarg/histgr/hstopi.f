C
C $Id: hstopi.f,v 1.5 2000-08-22 15:04:48 haley Exp $
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
C *************************************************************
C
      SUBROUTINE HSTOPI (STRING, PARAM1, PARAM2, ICOL, LCOL)
C
C *************************************************************
C
C SET THE HISTOGRAM OPTIONS
C
C INPUT
C     STRING- Character string specifying option on or off;
C             valid options are:
C             'COL=ON/OFF'
C             'CLA=ON/OFF'
C
C     PARAM1- Integer variable used to set:
C             character height of class labels if 'CLA=ON';
C             1 = small, 2 = medium, 3 = large;
C
C     PARAM2- Integer variable used to set:
C             orientation of class labels, from 0 (horizontal)
C             to 90 (vertical) degrees when 'CLA=ON';
C
C     ICOL- Integer array containing values defining color
C             indices 1-8, for use with 'COL=ON'
C
C     LCOL- Length of array ICOL, maximum of 8
C
C  SET COMMON DATA EQUAL TO INPUT DATA
C
C
C
      COMMON /HSTGC1/ HORZNT, PERCNT, MIDVAL, SHADE, MEDIAN, PERIM,
     -       HFRAME, LISTOP, WINDOW, COLORS, HSTFOR, TITLE, LABEL,
     -       FREQNC, HWIND(4), COLSHA, COLREC, COLAXI, COLMED, COLTEX,
     -       COLTIT, COLPER, DRAWL, SPACE, LABMAX, CHARL, HEIGHT,
     -       ORIENT, COLSH2, SETSPA, SETSP2, MVALU, SETMVA, SETEPS,
     -       NMVAL, PMVAL, PERTIT
      LOGICAL HORZNT, PERCNT, MIDVAL, SHADE, MEDIAN, PERIM, HFRAME,
     -        LISTOP, WINDOW, COLORS, HSTFOR, TITLE, LABEL, FREQNC,
     -        DRAWL, SPACE, CHARL, MVALU, NMVAL, PMVAL, PERTIT
      CHARACTER*(*)  STRING
      CHARACTER*2  TAG, OPT
      INTEGER COLSHA, COLREC, COLAXI, COLMED, COLTEX, PARAM1, PARAM2
      INTEGER COLTIT, COLPER, HEIGHT, ORIENT, ICOL(LCOL),COLSH2
C
C
      NERR = 0
      IF (LCOL .NE. 8) GOTO 930
C
C  DETERMINE OPTION AND ITS VALUE
C
      TAG = STRING(1:2)
      IF (STRING(3:3) .EQ. '=') THEN
          OPT = STRING(4:5)
      ELSE
          OPT = STRING(5:6)
      ENDIF
C
C COLOR option and set color indices
C
      IF (TAG .EQ. 'CO') THEN
        IF (OPT .EQ. 'ON') THEN
          COLORS = .TRUE.
          COLSHA = ICOL(1)
          COLSH2 = ICOL(2)
          COLREC = ICOL(3)
          COLAXI = ICOL(4)
          COLMED = ICOL(5)
          COLTEX = ICOL(6)
          COLTIT = ICOL(7)
          COLPER = ICOL(8)
C
C  SWITCH = OFF
C
        ELSE
          COLORS = .FALSE.
          COLSHA = 1.
          COLSH2 = 1.
          COLREC = 1.
          COLAXI = 1.
          COLMED = 1.
          COLTEX = 1.
          COLTIT = 1.
          COLPER = 1.
        ENDIF
        RETURN
C
C Class-Label FLAG
C
      ELSEIF (TAG .EQ. 'CL') THEN
C
C Assign class-label height and orientation
C
        IF (OPT .EQ. 'ON') THEN
          HEIGHT = PARAM1
          ORIENT = PARAM2
          IF(PARAM1 .LT. 1) HEIGHT = 1
          IF(PARAM1 .GT. 3) HEIGHT = 3
          RETURN
        ENDIF
      ELSE
        GOTO 910
      ENDIF
  910 NERR = NERR + 1
      CALL SETER (' HSTOPI -- UNDEFINED OPTION',NERR,IREC)
      RETURN
  930 NERR = NERR + 1
      CALL SETER (' HSTOPI -- LCOL MUST EQUAL 8 ',NERR,IREC)
      RETURN
      END
