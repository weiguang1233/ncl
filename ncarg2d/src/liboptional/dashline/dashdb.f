C
C	$Id: dashdb.f,v 1.3 2000-08-22 15:10:16 haley Exp $
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
      SUBROUTINE DASHDB (IPAT)
C
C Software dashed line package
C
C PURPOSE                DASHLINE is a software dashed line package.
C                        Some hardware dashed line generators
C                        fail to produce pleasing results when
C                        drawing very short vector segments or
C                        vector segments of varying lengths.  This
C                        package does not have this problem.
C
C USAGE                  First,
C                             CALL DASHDB (IPAT)
C
C                        Then, call any of the following:
C                             CALL CURVED (X,Y,N)
C                             CALL FRSTD (X,Y)
C                             CALL VECTD (X,Y)
C                             CALL LINED (XA,YA,XB,YB)
C
C
C ARGUMENTS             DASHDB (IPAT)
C ON INPUT                IPAT is a 16-bit dash pattern.  By default
C                         each bit in the pattern represents 3 plotter
C                         address units (1=solid, 0=blank)
C
C ARGUMENTS TO           CURVED(X,Y,N)
C OTHER LINE-DRAWING       X and Y are arrays of world coordinate values
C ROUTINES                 of length N or greater.  Line segments obeying
C                          the specified dash pattern are drawn to
C                          connect the N points.
C
C                        FRSTD(X,Y)
C                          The current pen position is set to
C                          the world coordinate value (X,Y)
C
C                        VECTD(X,Y)
C                          A line segment is drawn between the
C                          world coordinate value (X,Y) and the
C                          most recent pen position.  (X,Y) then
C                          becomes the most recent pen position.
C
C                        LINED(XA,XB,YA,YB)
C                          A line is drawn between world coordinate
C                          values (XA,YA) and (XB,YB).
C
C ON OUTPUT                All arguments are unchanged for all routines.
C
C ENTRY POINTS             DASHDB, CURVED, FRSTD, VECTD, LINED,
C                          LASTD, CFVLD, DRAWPV, DASHBD
C
C COMMON BLOCKS            INTPR, DSHD, DSHDA, DSHDD, DSHDC, DSHDB
C
C REQUIRED LIBRARY         The ERPRT77 package and the SPPS.
C ROUTINES
C
C REQUIRED GKS LEVEL       0A
C
C PRECISION                Single
C
C LANGUAGE                 FORTRAN
C
C HISTORY                  Written in 1969, standardized in November 1972.
C                          Made portable in September 1977 for use
C                          with all computer systems having at least
C                          a 16-bit word.
C                          Converted to FORTRAN77 and GKS in April 1984.
C
C ALGORITHM                The position in the dash pattern is
C                          remembered as points are processed.  The
C                          distance transversed in plotter address space
C                          is used to determine whether to draw segments,
C                          parts of segments, characters, or nothing.
C                          The plotter address space is 1024 X 1024.
C
C ACCURACY                 Plus or minus .5 plotter address units per call.
C                          There is no cumulative error.
C
C TIMING                   For solid or blank lines, there is almost no
C                          overhead.  Dashed lines take about 4 times as
C                          long as drawing solid lines.  (The line
C                          drawing software is so fast that the increase
C                          will not be noticed in most programs.)
C
C PORTABILITY              FORTRAN77
C
C INTERNAL PARAMETERS      NAME   DEFAULT  FUNCTION  DECLARED IN BLOCK DATA
C                          ----   -------  --------
C
C                          IPAU      3     Number of plotter addresses per
C                                          element in the dash pattern for
C                                          solid lines and gaps. The
C                                          pattern is repeated every
C                                          IPAU*16 plotter address units.
C
C                          ICLOSE    6     An internal or external call to
C                                          set the pen (pen-up) to a
C                                          specific position is executed
C                                          only if this position is
C                                          more than ICLOSE metacode
C                                          address units away from the
C                                          current pen position (distance=
C                                          difference in X-coordinates +
C                                          difference in Y-coordinates).
C
C
C
C
C
C
C
      COMMON/INTPR/IPAU,FPART,TENSN,NP,SMALL,L1,ADDLR,ADDTB,MLLINE,
     1    ICLOSE
C
C USER ENTRY POINT.
C DASHDB GIVES AN INTERNAL REPRESENTATION TO THE DASH PATTERN WHICH IS
C SPECIFIED IN ITS ARGUMENTS. THIS INTERNAL REPRESENTATION IS PASSED
C TO ROUTINE CFVLD IN THE COMMON-BLOCK DSHD.
C
C
C IN DSHD AN INTERNAL REPRESENTATION OF THE DASH PATTERN IS PASSED TO
C ROUTINE CFVLD.
      COMMON /DSHD/   ISL        ,L          ,IP(16)
C IFSTFL IS A FLAG TO CONTROL THAT FRSTD IS CALLED BEFORE VECTD IS
C CALLED.
      COMMON /DSHDA/  IFSTFL
C
C IFCFLG IS THE FIRST CALL FLAG FOR DASHDB. IT IS INITIALIZED IN DASHBD.
C MASK HAS TO BE SAVED FOR SUBSEQUENT CALLS TO DASHDB.
C
      COMMON /DSHDD/ IFCFLG, MASK
C
C NECESSARY ON SOME MACHINES TO GET BLOCK DATA LOADED
C
      EXTERNAL DASHBD
      SAVE
C
C THE FOLLOWING CALL IS FOR LIBRARY STAISTICS GATHERING AT NCAR
C
      CALL Q8QST4 ('GRAPHX', 'DASHLINE', 'DASHDB', 'VERSION 01')
      IF (IFCFLG .EQ. 2) GOTO 10
C
C CHECK IF THE CONSTANTS IN THE BLOCKDATA DASHBD ARE LOADED CORRECTLY.
C
      IF (ISL .EQ. 1) GOTO 6
      CALL SETER('DASHDB - BLOCKDATA DASHBD APPARRENTLY NOT LOADED CORRE
     -CTLY',1,2)
    6 CONTINUE
C
C INITIALIZATION
C
C MASK IS AN ALL SOLID PATTERN TO BE PASSED TO OPTN (65535=177777B).
C
      MASK=IOR(ISHIFT(32767,1),1)
C
      IFCFLG = 2
C
C L - NUMBER OF WORDS IN THE FINAL PATTERN, POINTER TO IP ARRAY.
C ISL - FLAG FOR ALL SOLID PATTERN (1) OR ALL GAP PATTERN (-1).
C IFSTFL - FLAG TO CONTROL THAT FRSTD IS CALLED IN CFVLD BEFORE VECTD IS
C          CALLED, WHENEVER DASHDB HAS BEEN CALLED.
C
   10 CONTINUE
      L = 0
      ISL = 0
      IFSTFL = 1
C
C     FOR EXAMPLE, IF IPAT IS 0010001100000000 (BINARY), THEN L=5 AND
C       IP(1) = -2*IPAU
C       IP(2) =  1*IPAU
C       IP(3) = -3*IPAU
C       IP(4) =  2*IPAU
C       IP(5) = -8*IPAU
C
      ICRT = IPAU*ISHIFT(1,15-10)
      IF (IPAT .NE. 0) GO TO 260
      ISL = -1
      RETURN
  260 IF (IPAT .NE. MASK) GOTO 270
      ISL = 1
      RETURN
  270 NMODE1 = IAND(ISHIFT(IPAT,-15),1)
      DO 290 I = 1,16
      IF (NMODE1 .NE. IAND(ISHIFT(IPAT,I-16),1)) GO TO 280
      NMODE1 = 1 - NMODE1
      L = L + 1
      IP(L) = 0
  280 IP(L) = IP(L) + ICRT*(1-2*NMODE1)
  290 CONTINUE
      RETURN
      END
