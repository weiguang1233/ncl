C
C $Id: idxchn.f,v 1.3 2000-08-22 15:06:55 haley Exp $
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
      FUNCTION IDXCHN (X,Y,I1,I2,I3,I4)
C
        DIMENSION X(*),Y(*)
C
C This function determines whether or not two adjacent triangles in
C the triangulation should be "exchanged".  It generates the Delaunay
C triangulation, used by the package "nngridr", by preferring triangles
C whose circumscribed circles have no data points in their interiors.
C
C The input arguments are the X and Y coordinate arrays of the data and
C the indices of four data points - P1, P2, P3, and P4 - forming a
C quadrilateral, with P3 and P4 connected diagonally.  The function
C returns a 1 when it decides that P1 and P2 should be connected
C instead (an "exchange") and a 0 otherwise.
C
        VPDT(U1,V1,U2,V2,U3,V3)=(U1-U3)*(V2-V3)-(V1-V3)*(U2-U3)
C
C Extract the required coordinates.
C
        X1=X(I1)
        Y1=Y(I1)
        X2=X(I2)
        Y2=Y(I2)
        X3=X(I3)
        Y3=Y(I3)
        X4=X(I4)
        Y4=Y(I4)
C
C Assume no exchange (value = 0) until we find out otherwise.
C
        IVAL=0
C
C If interior angles are less than 180 degrees, and either the point
C (X2,Y2) is inside the circle passing through the points (X1,Y1),
C (X3,Y3), and (X4,Y4) or the point (X1,Y1) is inside the circle
C passing through the points (X2,Y2), (X3,Y3), and (X4,Y4), return
C the value 1; this will cause the triangulation to be changed so
C as to use the diagonal from point 1 to point 2, rather than the
C diagonal from point 3 to point 4.  (Note that, mathematically, only
C one of the tests inside the IF-block should need to be made, because
C passing one of the tests implies passing the other, as well.)
C
        IF (VPDT(X1,Y1,X2,Y2,X3,Y3)*VPDT(X1,Y1,X2,Y2,X4,Y4).LT.0.) THEN
          CALL IDGTCP (X1,Y1,X3,Y3,X4,Y4,XC,YC)
          IF ((X2-XC)*(X2-XC)+(Y2-YC)*(Y2-YC).LT.
     +        (X1-XC)*(X1-XC)+(Y1-YC)*(Y1-YC)) IVAL=1
          CALL IDGTCP (X2,Y2,X3,Y3,X4,Y4,XC,YC)
          IF ((X1-XC)*(X1-XC)+(Y1-YC)*(Y1-YC).LT.
     +        (X2-XC)*(X2-XC)+(Y2-YC)*(Y2-YC)) IVAL=1
        END IF
C
C Set the value of the function for return to the caller.
C
        IDXCHN=IVAL
C
C Done.
C
        RETURN
C
      END
