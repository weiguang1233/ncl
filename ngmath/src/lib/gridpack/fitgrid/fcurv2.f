C
C $Id: fcurv2.f,v 1.3 2000-08-22 15:19:35 haley Exp $
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
      SUBROUTINE FCURV2(N,XI,YI,YP,SIGMA,M,XO,YO)
C
      DIMENSION XI(N),YI(N),YP(N),XO(M),YO(M)
C
      DO 10 I=1,M
        YO(I) = CURV2(XO(I),N,XI,YI,YP,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FCURVD(N,XI,YI,YP,SIGMA,M,XO,YO)
C
      DIMENSION XI(N),YI(N),YP(N),XO(M),YO(M)
C
      DO 10 I=1,M
        YO(I) = CURVD(XO(I),N,XI,YI,YP,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FCURVI(XL,XR,N,XI,YI,YP,SIGMA,FINT)
C
      DIMENSION XI(N),YI(N),YP(N)
C
      FINT = CURVI(XL,XR,N,XI,YI,YP,SIGMA)
C
      RETURN
      END
      SUBROUTINE FCURVP2(N,XI,YI,YP,P,SIGMA,M,XO,YO)
C
      DIMENSION XI(N),YI(N),YP(N),XO(M),YO(M)
C
      DO 10 I=1,M
        YO(I) = CURVP2(XO(I),N,XI,YI,P,YP,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FCURVPI(XL,XR,P,N,XI,YI,YP,SIGMA,FINT)
C
      DIMENSION XI(N),YI(N),YP(N)
C
      FINT = CURVPI(XL,XR,N,XI,YI,P,YP,SIGMA)
C
      RETURN
      END
      SUBROUTINE FKURV2(N,XI,YI,M,T,XO,YO,XP,YP,S,SIGMA)
C
      DIMENSION XI(N),YI(N),YP(N),S(N),T(M),XO(M),YO(M)
C
      DO 10 I=1,M
        CALL KURV2(T(I),XO(I),YO(I),N,XI,YI,XP,YP,S,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FKURVP2(N,XI,YI,M,T,XO,YO,XP,YP,S,SIGMA)
C
      DIMENSION XI(N),YI(N),YP(N),S(N),T(M),XO(M),YO(M)
C
      DO 10 I=1,M
        CALL KURVP2(T(I),XO(I),YO(I),N,XI,YI,XP,YP,S,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FKURVD(N,XI,YI,M,T,XO,YO,XD,YD,XDD,YDD,XP,YP,S,SIGMA)       
C
      DIMENSION XI(N),YI(N),YP(N),S(N),T(M),XO(M),YO(M),
     +          XD(M),YD(M),XDD(M),YDD(M)
C
      DO 10 I=1,M
        CALL KURVD(T(I),XO(I),YO(I),XD(I),YD(I),XDD(I),YDD(I),N,XI,YI,
     +             XP,YP,S,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FKURVPD(N,XI,YI,M,T,XO,YO,XD,YD,XDD,YDD,XP,YP,S,SIGMA)       
C
      DIMENSION XI(N),YI(N),YP(N),S(N),T(M),XO(M),YO(M),
     +          XD(M),YD(M),XDD(M),YDD(M)
C
      DO 10 I=1,M
        CALL KURVPD(T(I),XO(I),YO(I),XD(I),YD(I),XDD(I),YDD(I),N,XI,YI,       
     +             XP,YP,S,SIGMA)
   10 CONTINUE
C
      RETURN
      END
      SUBROUTINE FSURF2(SVALUE,XO,YO,M,N,XI,YI,ZI,IZ,ZP,SIGMA)
C
      DIMENSION XI(M),YI(N),ZI(IZ,N),ZP(M,N,3)
C
      SVALUE = SURF2(XO,YO,M,N,XI,YI,ZI,IZ,ZP,SIGMA)
C
      RETURN
      END
