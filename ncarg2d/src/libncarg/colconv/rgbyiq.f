C
C	$Id: rgbyiq.f,v 1.3 2000-08-22 15:02:30 haley Exp $
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
      SUBROUTINE RGBYIQ ( R, G, B, Y, I, Q )
C
C_BEGIN PROLOGUE RGBYIQ
C
C_PURPOSE
C    This subroutine converts a color specification given as
C    Red, Green, and Blue intensity values to a color specification
C    in the YIQ color space.
C
C_DESCRIPTION
C    This subroutine converts color values given in the
C    Red, Green, Blue (RGB) color space to color values
C    in the YIQ color space.  The input Red, Green,
C    and Blue values are intensities in the range [0.,1.] .
C
C_ARGUMENTS
C
C R       (INPUT,SINGLE,VARIABLE)  A real variable in the range
C         [0.,1.] which represents the red intensity component
C         of the input point in RGB color space.
C
C G       (INPUT,SINGLE,VARIABLE)  A real variable in the range
C         [0.,1.] which represents the green intensity component
C         of the input point in RGB color space.
C
C B       (INPUT,SINGLE,VARIABLE)  A real variable in the range
C         [0.,1.] which represents the blue intensity component
C         of the input point in RGB color space.
C
C Y       (OUTPUT,SINGLE,VARIABLE)  A real variable in the range
C         [0.,1.] .  Y is the color component of a television
C         signal which is shown on black-and-white televisions;
C         Y minimizes the effect of two colors appearing different
C         to the human eye but mapping to similar monochrome
C         intensities.
C
C I       (OUTPUT,SINGLE,VARIABLE)  A real variable in the range
C         [-.6,.6] .  I attains its maximum when the input triple
C         is (1.,0.,0.); I attains its minimum when the input triple
C         is (0.,1.,1.) .
C
C Q       (OUTPUT,SINGLE,VARIABLE)  A real variable in the range
C         [-.52,.52].  Q attains its maximum when the input triple
C         is (1.,0.,1.); Q attains its minimum when the input triple
C         is (0.,1.,0.).
C
C_I/O
C    (NONE)
C
C_ROUTINES CALLED
C    (NONE)
C
C_COMMON BLOCKS
C    (NONE)
C
C_MAXIMUM GKS LEVEL
C    (NONE)
C
C_LANGUAGE
C    FORTRAN
C
C_REVISION DATE
C    880511 (YYMMDD)
C
C_HISTORY
C    This subroutine was originally coded and prepared for the
C    NCAR Graphics package by Fred Clare based on algorithms
C    in Foley and van Dam (see REFERENCES below).
C
C_REFERENCES
C    Foley, James D. and van Dam, Andries,"Fundamentals of Interactive
C    Computer Graphics",Addison-Wesley Publishing Company, 1982.
C
C_EXAMPLES
C    Example 1 --  Full white to YIQ.
C          SUBROUTINE TYIQ1
C          REAL    Y,I,Q,EPS
C          PARAMETER (EPS=0.01)
C          CALL RGBYIQ(1.,1.,1.,Y,I,Q)
C          IF ( (ABS(Y-1.) .GT. EPS) .OR. (ABS(I) .GT. EPS) .OR.
C         *     (ABS(Q) .GT. EPS) ) THEN
C            IUN = I1MACH(4)
C            WRITE(IUN,10)
C          ENDIF
C          RETURN
C       10 FORMAT(' TYIQ1 returned incorrect values')
C          END
C
C_END PROLOGUE RGBYIQ
C
      REAL R,G,B,Y,I,Q
C
C_FIRST EXECUTABLE STATEMENT RGBYIQ
      Y = 0.30*R + 0.59*G + 0.11*B
      I = 0.60*R - 0.28*G - 0.32*B
      Q = 0.21*R - 0.52*G + 0.31*B
C
      RETURN
      END
