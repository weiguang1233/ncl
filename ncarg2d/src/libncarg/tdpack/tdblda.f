C
C $Id: tdblda.f,v 1.3 2000-08-22 15:07:06 haley Exp $
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
      BLOCK DATA TDBLDA
C
C This "routine" defines the default values of various quantities in
C common.
C
C The variables in the following common block define the mapping from
C 3-space to 2-space.
C
        COMMON /TDCOM1/ IH,IT,XM,YM,ZM,XO,YO,ZO,XT,YT,ZT,OE,XE,YE,ZE
        COMMON /TDCOM1/ A1,B1,C1,D1,E1,A2,B2,C2,D2,E2,A3,B3,C3,D3,E3
        COMMON /TDCOM1/ IS,FV,VL,VR,VB,VT,WL,WR,WB,WT
        SAVE   /TDCOM1/
C
C The variables in the following common block define a parallelogram.
C
        COMMON /TDCOM2/ XACP,YACP,ZACP,XCDX,YCDX,ZCDX,XCDY,YCDY,ZCDY
        SAVE   /TDCOM2/
C
C The variables in the following common block define a number of
C different rendering styles for surfaces defined by triangles.
C
        COMMON /TDCOM3/ IFC1(64),IFC2(64),IFC3(64),IFC4(64),ILC1(64)
        COMMON /TDCOM3/ ILC2(64),ILTD(64),USTP(64),VSTP(64),WSTP(64)
        SAVE   /TDCOM3/
C
C The variables in the following common block together determine how
C big characters written by TDLBLA will be.  Both can be set through
C the TDPACK parameter-setting interface.
C
        COMMON /TDCOM4/ CSM1,CSM2
        SAVE   /TDCOM4/
C
C The variables in the following common block define the triangles
C making up various kinds of three-dimensional markers.
C
        COMMON /TDCOM5/ TMK1(36),TMK2(72),TMK3(108),TMK4(180),TMK5(720)
        SAVE   /TDCOM5/
C
C The variables in the following common block define the shading type
C and the position of the light source.
C
        COMMON /TDCOM6/ ISHD,XPLS,YPLS,ZPLS
        SAVE   /TDCOM6/
C
C A1, B1, C1, D1, and E1 are quantities computed by TDINIT, describing
C plane 1.
C
        DATA A1,B1,C1,D1,E1 /-.2797514,-.4662524,-.8392543,0.,-10.72381/
C
C A2, B2, C2, D2, and E2 are quantities computed by TDINIT, describing
C plane 2.
C
        DATA A2,B2,C2,D2,E2 /.8574929,-.5144957,0.,0.,0./
C
C A3, B3, C3, D3, and E3 are quantities computed by TDINIT, describing
C plane 3.
C
        DATA A3,B3,C3,D3,E3 /-0.4317928,-.7196546,.5437390,0.,0./
C
C FV is the desired field of view, in degrees, to be used when IS is
C non-zero.
C
        DATA FV / 20. /
C
C IH is the internal parameter 'HND', which says whether the 3D
C coordinate system is right-handed (0) or left-handed (1).
C
        DATA IH / 0 /
C
C IS is the internal parameter 'SET', which says whether a SET call is
C to be done by TDINIT or not.  Use the value 0 if no SET call is to be
C done, the value 1 otherwise
C
        DATA IS / 1 /
C
C IT is the internal parameter 'STE', which says whether stereo views
C are to be done using a single image plane which is perpendicular to
C the line connecting (XO,YO,ZO) to (XM,YM,ZM) or to (XE,YE,ZE).  For
C the former case, use 'STE' = 0; for the latter, use 'STE' = 1.
C
        DATA IT / 0 /
C
C OE is the offset to the current eye position.  Use a zero if only one
C eye is in use, a negative value for the left eye, and a positive value
C for the right eye.
C
        DATA OE / 0. /
C
C VL, VR, VB, and VT define the viewport to be used in a call to SET
C done by TDINIT.
C
        DATA VL,VR,VB,VT / .05,.95,.05,.95 /
C
C WL, WR, WB, WT define the window to be used in a call to SET done by
C TDINIT.
C
        DATA WL,WR,WB,WT / -1.890896,1.890896,-1.890896,1.890896/
C
C (XE,YE,ZE) is the position of the eye from which a view is currently
C being drawn.
C
        DATA XE,YE,ZE / 3.,5.,9. /
C
C (XM,YM,ZM) is the midpoint of the line joining the left eye to the
C right eye.
C
        DATA XM,YM,ZM / 3.,5.,9. /
C
C (XO,YO,ZO) is the point at the origin of the image plane.
C
        DATA XO,YO,ZO / 0.,0.,0. /
C
C (XT,YT,ZT) is the third point required to define the plane of
C bilateral symmetry of the observer, a plane perpendicular to the
C line from the left eye to the right eye.
C
        DATA XT,YT,ZT / 0.,0.,10. /
C
C For a rendering style I from 1 to 64, inclusive, IFC1(I) and IFC2(I)
C specify colors to be used to fill triangles on the "low" side of
C the surface, while IFC3(I) and IFC4(I) specify colors to be used to
C fill triangles on the "high" side of the surface; similarly, ILC1(I)
C and ILC2(I) specify colors to be used in drawing lines on the "low"
C side and the "high" side, respectively.  It is difficult to set up
C really good defaults for these because, to do that, we would need to
C know what ranges of color indices the user has defined; instead, we
C use the principal foreground and the background colors for everything.
C
        DATA IFC1 / 64*0  /
        DATA IFC2 / 64*0  /
        DATA IFC3 / 64*1  /
        DATA IFC4 / 64*1  /
        DATA ILC1 / 64*1  /
        DATA ILC2 / 64*0  /
        DATA ILTD / 64*0  /
        DATA USTP / 64*1. /
        DATA VSTP / 64*1. /
        DATA WSTP / 64*1. /
C
C CSM1 and CSM2 are "character size multipliers".
C
        DATA CSM1,CSM2 / 2*1. /
C
C Define a tetrahedron.
C
        DATA (TMK1(I),I=  1, 36) /
     +   0.9428090453148, 0.0000000000000,-0.3333333432674,
     +  -0.4714045226574, 0.8164966106415,-0.3333333432674,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -0.4714045226574, 0.8164966106415,-0.3333333432674,
     +  -0.4714045226574,-0.8164966106415,-0.3333333432674,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -0.4714045226574,-0.8164966106415,-0.3333333432674,
     +   0.9428090453148, 0.0000000000000,-0.3333333432674,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -0.4714045226574, 0.8164966106415,-0.3333333432674,
     +   0.9428090453148, 0.0000000000000,-0.3333333432674,
     +  -0.4714045226574,-0.8164966106415,-0.3333333432674/
C
C Define an octahedron.
C
        DATA (TMK2(I),I=  1, 36) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000, 1.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +   0.0000000000000, 1.0000000000000, 0.0000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000,-1.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +   0.0000000000000,-1.0000000000000, 0.0000000000000,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000/
C
        DATA (TMK2(I),I= 37, 72) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000,-1.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +   0.0000000000000,-1.0000000000000, 0.0000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000, 1.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +   0.0000000000000, 1.0000000000000, 0.0000000000000,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000/
C
C Define a twelve-triangle cube.
C
        DATA (TMK3(I),I=  1, 36) /
     +   0.5773502588272,-0.5773502588272,-0.5773502588272,
     +   0.5773502588272, 0.5773502588272,-0.5773502588272,
     +   0.5773502588272, 0.5773502588272, 0.5773502588272,
     +   0.5773502588272, 0.5773502588272,-0.5773502588272,
     +  -0.5773502588272, 0.5773502588272,-0.5773502588272,
     +  -0.5773502588272, 0.5773502588272, 0.5773502588272,
     +  -0.5773502588272, 0.5773502588272,-0.5773502588272,
     +  -0.5773502588272,-0.5773502588272,-0.5773502588272,
     +  -0.5773502588272,-0.5773502588272, 0.5773502588272,
     +  -0.5773502588272,-0.5773502588272,-0.5773502588272,
     +   0.5773502588272,-0.5773502588272,-0.5773502588272,
     +   0.5773502588272,-0.5773502588272, 0.5773502588272/
C
        DATA (TMK3(I),I= 37, 72) /
     +   0.5773502588272, 0.5773502588272, 0.5773502588272,
     +   0.5773502588272,-0.5773502588272, 0.5773502588272,
     +   0.5773502588272,-0.5773502588272,-0.5773502588272,
     +  -0.5773502588272, 0.5773502588272, 0.5773502588272,
     +   0.5773502588272, 0.5773502588272, 0.5773502588272,
     +   0.5773502588272, 0.5773502588272,-0.5773502588272,
     +  -0.5773502588272,-0.5773502588272, 0.5773502588272,
     +  -0.5773502588272, 0.5773502588272, 0.5773502588272,
     +  -0.5773502588272, 0.5773502588272,-0.5773502588272,
     +   0.5773502588272,-0.5773502588272, 0.5773502588272,
     +  -0.5773502588272,-0.5773502588272, 0.5773502588272,
     +  -0.5773502588272,-0.5773502588272,-0.5773502588272/
C
        DATA (TMK3(I),I= 73,108) /
     +   0.5773502588272,-0.5773502588272, 0.5773502588272,
     +   0.5773502588272, 0.5773502588272, 0.5773502588272,
     +  -0.5773502588272,-0.5773502588272, 0.5773502588272,
     +  -0.5773502588272,-0.5773502588272, 0.5773502588272,
     +   0.5773502588272, 0.5773502588272, 0.5773502588272,
     +  -0.5773502588272, 0.5773502588272, 0.5773502588272,
     +   0.5773502588272, 0.5773502588272,-0.5773502588272,
     +   0.5773502588272,-0.5773502588272,-0.5773502588272,
     +  -0.5773502588272, 0.5773502588272,-0.5773502588272,
     +   0.5773502588272,-0.5773502588272,-0.5773502588272,
     +  -0.5773502588272,-0.5773502588272,-0.5773502588272,
     +  -0.5773502588272, 0.5773502588272,-0.5773502588272/
C
C Define an icosahedron.
C
        DATA (TMK4(I),I=  1, 36) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535/
C
        DATA (TMK4(I),I= 37, 72) /
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356/
C
        DATA (TMK4(I),I= 73,108) /
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356/
C
        DATA (TMK4(I),I=109,144) /
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356/
C
        DATA (TMK4(I),I=145,180) /
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356/
C
C Define an elaborated icosahedron.
C
        DATA (TMK5(I),I=  1, 36) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.8506507873535, 0.5257310867310, 0.0000000000000,
     +   0.8506507873535, 0.1624598354101, 0.5000000000000,
     +   0.8506507873535, 0.5257310867310, 0.0000000000000,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.5257311463356, 0.6881909370422, 0.5000000000000,
     +   0.8506507873535, 0.1624598354101, 0.5000000000000,
     +   0.5257311463356, 0.6881909370422, 0.5000000000000,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   0.8506507873535, 0.5257310867310, 0.0000000000000,
     +   0.5257311463356, 0.6881909370422, 0.5000000000000,
     +   0.8506507873535, 0.1624598354101, 0.5000000000000/
C
        DATA (TMK5(I),I= 37, 72) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.8506507873535, 0.1624598354101, 0.5000000000000,
     +   0.8506507873535,-0.4253253936768, 0.3090170025826,
     +   0.8506507873535, 0.1624598354101, 0.5000000000000,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   0.5257311463356,-0.2628656029701, 0.8090170025826,
     +   0.8506507873535,-0.4253253936768, 0.3090170025826,
     +   0.5257311463356,-0.2628656029701, 0.8090170025826,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.8506507873535, 0.1624598354101, 0.5000000000000,
     +   0.5257311463356,-0.2628656029701, 0.8090170025826,
     +   0.8506507873535,-0.4253253936768, 0.3090170025826/
C
        DATA (TMK5(I),I= 73,108) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.8506507873535,-0.4253253936768, 0.3090170025826,
     +   0.8506507873535,-0.4253253936768,-0.3090170025826,
     +   0.8506507873535,-0.4253253936768, 0.3090170025826,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.5257310867310,-0.8506507873535, 0.0000000000000,
     +   0.8506507873535,-0.4253253936768,-0.3090170025826,
     +   0.5257310867310,-0.8506507873535, 0.0000000000000,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.8506507873535,-0.4253253936768, 0.3090170025826,
     +   0.5257310867310,-0.8506507873535, 0.0000000000000,
     +   0.8506507873535,-0.4253253936768,-0.3090170025826/
C
        DATA (TMK5(I),I=109,144) /
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.8506507873535,-0.4253253936768,-0.3090170025826,
     +   0.8506507873535, 0.1624598354101,-0.5000000000000,
     +   0.8506507873535,-0.4253253936768,-0.3090170025826,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.5257311463356,-0.2628656029701,-0.8090170025826,
     +   0.8506507873535, 0.1624598354101,-0.5000000000000,
     +   0.5257311463356,-0.2628656029701,-0.8090170025826,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +   0.8506507873535,-0.4253253936768,-0.3090170025826,
     +   0.5257311463356,-0.2628656029701,-0.8090170025826,
     +   0.8506507873535, 0.1624598354101,-0.5000000000000/
C
        DATA (TMK5(I),I=145,180) /
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.8506507873535, 0.5257310867310, 0.0000000000000,
     +   0.5257311463356, 0.6881909370422,-0.5000000000000,
     +   0.8506507873535, 0.5257310867310, 0.0000000000000,
     +   1.0000000000000, 0.0000000000000, 0.0000000000000,
     +   0.8506507873535, 0.1624598354101,-0.5000000000000,
     +   0.5257311463356, 0.6881909370422,-0.5000000000000,
     +   0.8506507873535, 0.1624598354101,-0.5000000000000,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +   0.8506507873535, 0.5257310867310, 0.0000000000000,
     +   0.8506507873535, 0.1624598354101,-0.5000000000000,
     +   0.5257311463356, 0.6881909370422,-0.5000000000000/
C
        DATA (TMK5(I),I=181,216) /
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +   0.0000000000000, 0.9510564804077,-0.3090170025826,
     +  -0.0000000175174, 0.5877852439880,-0.8090170025826,
     +   0.0000000000000, 0.9510564804077,-0.3090170025826,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.5257311463356, 0.6881909370422,-0.5000000000000,
     +  -0.0000000175174, 0.5877852439880,-0.8090170025826,
     +   0.5257311463356, 0.6881909370422,-0.5000000000000,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +   0.0000000000000, 0.9510564804077,-0.3090170025826,
     +   0.5257311463356, 0.6881909370422,-0.5000000000000,
     +  -0.0000000175174, 0.5877852439880,-0.8090170025826/
C
        DATA (TMK5(I),I=217,252) /
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.0000000000000, 0.9510564804077,-0.3090170025826,
     +   0.0000000000000, 0.9510564804077, 0.3090170025826,
     +   0.0000000000000, 0.9510564804077,-0.3090170025826,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +  -0.5257310867310, 0.8506507873535, 0.0000000000000,
     +   0.0000000000000, 0.9510564804077, 0.3090170025826,
     +  -0.5257310867310, 0.8506507873535, 0.0000000000000,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +   0.0000000000000, 0.9510564804077,-0.3090170025826,
     +  -0.5257310867310, 0.8506507873535, 0.0000000000000,
     +   0.0000000000000, 0.9510564804077, 0.3090170025826/
C
        DATA (TMK5(I),I=253,288) /
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   0.5257311463356, 0.6881909370422, 0.5000000000000,
     +  -0.0000000175174, 0.5877852439880, 0.8090170025826,
     +   0.5257311463356, 0.6881909370422, 0.5000000000000,
     +   0.4472135901451, 0.8944271802902, 0.0000000000000,
     +   0.0000000000000, 0.9510564804077, 0.3090170025826,
     +  -0.0000000175174, 0.5877852439880, 0.8090170025826,
     +   0.0000000000000, 0.9510564804077, 0.3090170025826,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +   0.5257311463356, 0.6881909370422, 0.5000000000000,
     +   0.0000000000000, 0.9510564804077, 0.3090170025826,
     +  -0.0000000175174, 0.5877852439880, 0.8090170025826/
C
        DATA (TMK5(I),I=289,324) /
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +  -0.0000000175174, 0.5877852439880, 0.8090170025826,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -0.0000000175174, 0.5877852439880, 0.8090170025826,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +  -0.5257311463356, 0.2628656029701, 0.8090170025826,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -0.5257311463356, 0.2628656029701, 0.8090170025826,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -0.0000000175174, 0.5877852439880, 0.8090170025826,
     +  -0.5257311463356, 0.2628656029701, 0.8090170025826,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000/
C
        DATA (TMK5(I),I=325,360) /
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.5257311463356,-0.2628656029701, 0.8090170025826,
     +   0.0000000175174,-0.5877852439880, 0.8090170025826,
     +   0.5257311463356,-0.2628656029701, 0.8090170025826,
     +   0.4472135603428, 0.2763931751251, 0.8506507873535,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +   0.0000000175174,-0.5877852439880, 0.8090170025826,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +   0.5257311463356,-0.2628656029701, 0.8090170025826,
     +   0.0000000000000, 0.0000000000000, 1.0000000000000,
     +   0.0000000175174,-0.5877852439880, 0.8090170025826/
C
        DATA (TMK5(I),I=361,396) /
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +   0.0000000000000,-0.9510564804077, 0.3090170025826,
     +  -0.5257311463356,-0.6881909370422, 0.5000000000000,
     +   0.0000000000000,-0.9510564804077, 0.3090170025826,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.0000000175174,-0.5877852439880, 0.8090170025826,
     +  -0.5257311463356,-0.6881909370422, 0.5000000000000,
     +   0.0000000175174,-0.5877852439880, 0.8090170025826,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +   0.0000000000000,-0.9510564804077, 0.3090170025826,
     +   0.0000000175174,-0.5877852439880, 0.8090170025826,
     +  -0.5257311463356,-0.6881909370422, 0.5000000000000/
C
        DATA (TMK5(I),I=397,432) /
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +   0.0000000000000,-0.9510564804077,-0.3090170025826,
     +   0.0000000000000,-0.9510564804077, 0.3090170025826,
     +   0.0000000000000,-0.9510564804077,-0.3090170025826,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.5257310867310,-0.8506507873535, 0.0000000000000,
     +   0.0000000000000,-0.9510564804077, 0.3090170025826,
     +   0.5257310867310,-0.8506507873535, 0.0000000000000,
     +   0.4472135901451,-0.7236068248749, 0.5257311463356,
     +   0.0000000000000,-0.9510564804077,-0.3090170025826,
     +   0.5257310867310,-0.8506507873535, 0.0000000000000,
     +   0.0000000000000,-0.9510564804077, 0.3090170025826/
C
        DATA (TMK5(I),I=433,468) /
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +  -0.5257311463356,-0.6881909370422,-0.5000000000000,
     +   0.0000000000000,-0.9510564804077,-0.3090170025826,
     +  -0.5257311463356,-0.6881909370422,-0.5000000000000,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +   0.0000000175174,-0.5877852439880,-0.8090170025826,
     +   0.0000000000000,-0.9510564804077,-0.3090170025826,
     +   0.0000000175174,-0.5877852439880,-0.8090170025826,
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +  -0.5257311463356,-0.6881909370422,-0.5000000000000,
     +   0.0000000175174,-0.5877852439880,-0.8090170025826,
     +   0.0000000000000,-0.9510564804077,-0.3090170025826/
C
        DATA (TMK5(I),I=469,504) /
     +   0.4472135901451,-0.7236068248749,-0.5257311463356,
     +   0.0000000175174,-0.5877852439880,-0.8090170025826,
     +   0.5257311463356,-0.2628656029701,-0.8090170025826,
     +   0.0000000175174,-0.5877852439880,-0.8090170025826,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +   0.5257311463356,-0.2628656029701,-0.8090170025826,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +   0.0000000175174,-0.5877852439880,-0.8090170025826,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +   0.5257311463356,-0.2628656029701,-0.8090170025826/
C
        DATA (TMK5(I),I=505,540) /
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +  -0.5257311463356, 0.2628656029701,-0.8090170025826,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +  -0.5257311463356, 0.2628656029701,-0.8090170025826,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +  -0.0000000175174, 0.5877852439880,-0.8090170025826,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000,
     +  -0.0000000175174, 0.5877852439880,-0.8090170025826,
     +   0.4472135603428, 0.2763931751251,-0.8506507873535,
     +  -0.5257311463356, 0.2628656029701,-0.8090170025826,
     +  -0.0000000175174, 0.5877852439880,-0.8090170025826,
     +   0.0000000000000, 0.0000000000000,-1.0000000000000/
C
        DATA (TMK5(I),I=541,576) /
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +  -0.8506507873535,-0.1624598354101,-0.5000000000000,
     +  -0.5257311463356, 0.2628656029701,-0.8090170025826,
     +  -0.8506507873535,-0.1624598354101,-0.5000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.8506507873535, 0.4253253936768,-0.3090170025826,
     +  -0.5257311463356, 0.2628656029701,-0.8090170025826,
     +  -0.8506507873535, 0.4253253936768,-0.3090170025826,
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +  -0.8506507873535,-0.1624598354101,-0.5000000000000,
     +  -0.8506507873535, 0.4253253936768,-0.3090170025826,
     +  -0.5257311463356, 0.2628656029701,-0.8090170025826/
C
        DATA (TMK5(I),I=577,612) /
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +  -0.8506507873535,-0.5257310867310, 0.0000000000000,
     +  -0.5257311463356,-0.6881909370422,-0.5000000000000,
     +  -0.8506507873535,-0.5257310867310, 0.0000000000000,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.8506507873535,-0.1624598354101,-0.5000000000000,
     +  -0.5257311463356,-0.6881909370422,-0.5000000000000,
     +  -0.8506507873535,-0.1624598354101,-0.5000000000000,
     +  -0.4472135603428,-0.2763931751251,-0.8506507873535,
     +  -0.8506507873535,-0.5257310867310, 0.0000000000000,
     +  -0.8506507873535,-0.1624598354101,-0.5000000000000,
     +  -0.5257311463356,-0.6881909370422,-0.5000000000000/
C
        DATA (TMK5(I),I=613,648) /
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.8506507873535,-0.5257310867310, 0.0000000000000,
     +  -0.8506507873535,-0.1624598354101, 0.5000000000000,
     +  -0.8506507873535,-0.5257310867310, 0.0000000000000,
     +  -0.4472135901451,-0.8944271802902, 0.0000000000000,
     +  -0.5257311463356,-0.6881909370422, 0.5000000000000,
     +  -0.8506507873535,-0.1624598354101, 0.5000000000000,
     +  -0.5257311463356,-0.6881909370422, 0.5000000000000,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -0.8506507873535,-0.5257310867310, 0.0000000000000,
     +  -0.5257311463356,-0.6881909370422, 0.5000000000000,
     +  -0.8506507873535,-0.1624598354101, 0.5000000000000/
C
        DATA (TMK5(I),I=649,684) /
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.8506507873535,-0.1624598354101, 0.5000000000000,
     +  -0.8506507873535, 0.4253253936768, 0.3090170025826,
     +  -0.8506507873535,-0.1624598354101, 0.5000000000000,
     +  -0.4472135603428,-0.2763931751251, 0.8506507873535,
     +  -0.5257311463356, 0.2628656029701, 0.8090170025826,
     +  -0.8506507873535, 0.4253253936768, 0.3090170025826,
     +  -0.5257311463356, 0.2628656029701, 0.8090170025826,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +  -0.8506507873535,-0.1624598354101, 0.5000000000000,
     +  -0.5257311463356, 0.2628656029701, 0.8090170025826,
     +  -0.8506507873535, 0.4253253936768, 0.3090170025826/
C
        DATA (TMK5(I),I=685,720) /
     +  -0.4472135901451, 0.7236068248749,-0.5257311463356,
     +  -0.8506507873535, 0.4253253936768,-0.3090170025826,
     +  -0.5257310867310, 0.8506507873535, 0.0000000000000,
     +  -0.8506507873535, 0.4253253936768,-0.3090170025826,
     +  -1.0000000000000, 0.0000000000000, 0.0000000000000,
     +  -0.8506507873535, 0.4253253936768, 0.3090170025826,
     +  -0.5257310867310, 0.8506507873535, 0.0000000000000,
     +  -0.8506507873535, 0.4253253936768, 0.3090170025826,
     +  -0.4472135901451, 0.7236068248749, 0.5257311463356,
     +  -0.8506507873535, 0.4253253936768,-0.3090170025826,
     +  -0.8506507873535, 0.4253253936768, 0.3090170025826,
     +  -0.5257310867310, 0.8506507873535, 0.0000000000000/
C
C Define the default value of the shading type parameter 'SHD' and the
C default position of the light source [(XM,YM,ZM)].
C
        DATA ISHD,XPLS,YPLS,ZPLS / 0 , 0. , 0. , 0. /
C
      END
