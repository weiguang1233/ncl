C
C $Id: mapblm.f,v 1.11 2000-08-22 15:03:58 haley Exp $
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
      SUBROUTINE MAPBLM (IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
C
      DIMENSION IAM(*),XCS(*),YCS(*),IAI(*),IAG(*)
C
C Declare required common blocks.
C
      COMMON /MAPCM1/ IPRJ,PHOC,IROD,RSNO,RCSO,RSNR,RCSR
      SAVE   /MAPCM1/
C
      COMMON /MAPDP1/ DSNO,DCSO,DSNR,DCSR
      DOUBLE PRECISION DSNO,DCSO,DSNR,DCSR
      SAVE   /MAPDP1/
C
      COMMON /MAPCM2/ UMIN,UMAX,VMIN,VMAX,UCEN,VCEN,URNG,VRNG,BLAM,SLAM,
     +                BLOM,SLOM,ISSL,PEPS
      SAVE   /MAPCM2/
C
      COMMON /MAPCM3/ ITPN,NOUT,NPTS,IGID,IDLS,IDRS,BLAG,SLAG,BLOG,SLOG,
     +                PNTS(200),IDOS(4)
      SAVE   /MAPCM3/
C
      COMMON /MAPCM4/ INTF,JPRJ,PHIA,PHIO,ROTA,ILTS,PLA1,PLA2,PLA3,PLA4,
     +                PLB1,PLB2,PLB3,PLB4,PLTR,GRID,IDSH,IDOT,LBLF,PRMF,
     +                ELPF,XLOW,XROW,YBOW,YTOW,IDTL,GRDR,SRCH,ILCW,GRLA,
     +                GRLO,GRPO
      LOGICAL         INTF,LBLF,PRMF,ELPF
      SAVE   /MAPCM4/
C
      COMMON /MAPCMC/ IGI1,IGI2,NOVS,XCRA(100),YCRA(100),NCRA
      SAVE   /MAPCMC/
C
      COMMON /MAPSAT/ SALT,SSMO,SRSS,ALFA,BETA,RSNA,RCSA,RSNB,RCSB
      SAVE   /MAPSAT/
C
      COMMON /USGSC1/ UTPA(15),UUMN,UUMX,UVMN,UVMX,IPRF
      DOUBLE PRECISION UTPA,UUMN,UUMX,UVMN,UVMX
      INTEGER IPRF
      SAVE   /USGSC1/
C
C Define some required double-precision variables.
C
      DOUBLE PRECISION DR,DS,DCOSB,DSINB,DCOSA,DSINA,DCOSPH,DSINPH,
     +                 DCOSLA,DSINLA
C
C Declare a couple of temporary arrays to hold coordinates of a circle.
C
      DIMENSION TLAT(361),TLON(361)
C
C Dimension the arrays needed to define some lines across the map.
C
      DIMENSION XCR(2),YCR(2)
C
C Define required constants.
C
      DATA DTOR / .017453292519943 /
      DATA DTRH / .008726646259971 /
      DATA RTOD / 57.2957795130823 /
C
C The arithmetic statement functions FLOOR and CLING give, respectively,
C the "floor" of X - the largest integer less than or equal to X - and
C the "ceiling" of X - the smallest integer greater than or equal to X.
C
      FLOOR(X)=REAL(DINT(DBLE(X)+1.D4)-1.D4)
      CLING(X)=-FLOOR(-X)
C
C Check for an uncleared prior error.
C
      IF (ICFELL('MAPBLM - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
C
C If EZMAP needs initialization, do it.
C
      IF (.NOT.(INTF)) GO TO 10000
      CALL MAPINT
      IF (ICFELL('MAPBLM',2).NE.0) RETURN
10000 CONTINUE
C
C If the perimeter is to be drawn ...
C
      IF (.NOT.(PRMF)) GO TO 10001
C
C ... reset the color index and dash pattern for the perimeter ...
C
      CALL MAPCHM (1,IOR(ISHIFT(32767,1),1),
     +                              IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',3).NE.0) RETURN
C
C .. and draw the perimeter.
C
      IF (.NOT.(ELPF)) GO TO 10002
      TEMP=.9998
10003 CONTINUE
      U=URNG
      V=0.
      XCRD=UCEN+TEMP*U
      YCRD=VCEN
      L10005=    1
      GO TO 10005
10004 CONTINUE
      I = 1
      GO TO 10008
10006 CONTINUE
      I =I +1
10008 CONTINUE
      IF (I .GT.(360)) GO TO 10007
      U=URNG*COS(DTOR*FLOAT(I))
      V=URNG*SIN(DTOR*FLOAT(I))
      XCRD=UCEN+TEMP*U
      YCRD=VCEN+TEMP*V*VRNG/URNG
      L10010=    1
      GO TO 10010
10009 CONTINUE
      GO TO 10006
10007 CONTINUE
      IF (TEMP.EQ.1.0002) GO TO 10011
      TEMP=1.0002
      GO TO 10003
10011 CONTINUE
      GO TO 10012
10002 CONTINUE
      XCRD=UMIN
      YCRD=VMIN
      L10005=    2
      GO TO 10005
10013 CONTINUE
      XCRD=UMAX
      YCRD=VMIN
      L10010=    2
      GO TO 10010
10014 CONTINUE
      XCRD=UMAX
      YCRD=VMAX
      L10010=    3
      GO TO 10010
10015 CONTINUE
      XCRD=UMIN
      YCRD=VMAX
      L10010=    4
      GO TO 10010
10016 CONTINUE
      XCRD=UMIN
      YCRD=VMIN
      L10010=    5
      GO TO 10010
10017 CONTINUE
10012 CONTINUE
      L10019=    1
      GO TO 10019
10018 CONTINUE
C
C Restore the color index and dash pattern.
C
      CALL MAPCHM (-1,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',4).NE.0) RETURN
C
10001 CONTINUE
C
C Reset the color index and dash pattern for limb lines.
C
      CALL MAPCHM (4,IOR(ISHIFT(32767,1),1),
     +                                IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',5).NE.0) RETURN
C
C Draw the limb line.
C
C Projection:   US  LC  ST  OR  LE  GN  AE  CE  ME  MO  RO
C
      GO TO (100,101,108,102,103,108,104,107,107,105,107,
     +                                   107,107,105,107) , IPRJ+1
C
C USGS transformations.
C
  100 CONTINUE
      IF (.NOT.(IPRF.EQ.3.OR.IPRF.EQ.4.OR.IPRF.EQ.5.OR.IPRF.EQ.7.OR.IPRF
     +.EQ.8.OR.IPRF.EQ.16.OR.IPRF.EQ.17.OR.IPRF.EQ.18.OR.IPRF.EQ.19.OR.I
     +PRF.EQ.21)) GO TO 10020
      IF (.NOT.(IPRF.EQ.3.OR.IPRF.EQ.8.OR.IPRF.EQ.17.OR.IPRF.EQ.18.OR.IP
     +RF.EQ.21)) GO TO 10021
      DLON=GRDR
      RLAT=-89.998
      K=CLING(360./DLON)
      DO 10022 I=1,2
      RLON=REAL(UTPA(5))-180.
      CALL MAPITM (RLAT,RLON,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',6).NE.0) RETURN
      DO 10023 J=1,K-1
      RLON=RLON+DLON
      CALL MAPITM (RLAT,RLON,1,
     +                        IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',7).NE.0) RETURN
10023 CONTINUE
      RLON=REAL(UTPA(5))+180.
      CALL MAPITM (RLAT,RLON,2,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',8).NE.0) RETURN
      CALL MAPIQM (            IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',9).NE.0) RETURN
      RLAT=89.998
10022 CONTINUE
      L10019=    2
      GO TO 10019
10024 CONTINUE
10021 CONTINUE
      IF (.NOT.(IPRF.EQ.7)) GO TO 10025
      DLON= 89.9999
      GO TO 10026
10025 CONTINUE
      DLON=179.9999
10026 CONTINUE
      DLAT=GRDR
      RLON=REAL(UTPA(5))+DLON
      K=CLING(180./DLAT)
      DO 10027 I=1,2
      RLAT=-90.
      CALL MAPITM (RLAT,RLON,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',10).NE.0) RETURN
      DO 10028 J=1,K-1
      RLAT=RLAT+DLAT
      CALL MAPITM (RLAT,RLON,1,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',11).NE.0) RETURN
10028 CONTINUE
      RLAT=90.
      CALL MAPITM (RLAT,RLON,2,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',12).NE.0) RETURN
      CALL MAPIQM (            IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',13).NE.0) RETURN
      RLON=REAL(UTPA(5))-DLON
10027 CONTINUE
      L10019=    3
      GO TO 10019
10029 CONTINUE
      GO TO 108
10020 CONTINUE
      IF (.NOT.(IPRF.EQ.9)) GO TO 10030
      DLON=GRDR
      RLAT=-.001
      K=CLING(180./DLON)
      DO 10031 I=1,2
      RLON=REAL(UTPA(5))+90.
      CALL MAPITM (RLAT,RLON,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',14).NE.0) RETURN
      DO 10032 J=1,K-1
      RLON=RLON+DLON
      CALL MAPITM (RLAT,RLON,1,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',15).NE.0) RETURN
10032 CONTINUE
      RLON=REAL(UTPA(5))+270.
      CALL MAPITM (RLAT,RLON,2,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',16).NE.0) RETURN
      CALL MAPIQM (            IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',17).NE.0) RETURN
      RLAT=.001
10031 CONTINUE
      L10019=    4
      GO TO 10019
10033 CONTINUE
      GO TO 108
10030 CONTINUE
      IF (.NOT.(IPRF.EQ.11.OR.IPRF.EQ.12.OR.IPRF.EQ.14.OR.IPRF.EQ.15.OR.
     +IPRF.EQ.23)) GO TO 10034
      IF (.NOT.(IPRF.EQ.11.OR.IPRF.EQ.12)) GO TO 10035
      CLAT=REAL(UTPA(6))
      CLON=REAL(UTPA(5))
      CRAD=179.95
      GO TO 10036
10035 CONTINUE
      IF (.NOT.(IPRF.EQ.14)) GO TO 10037
      CLAT=REAL(UTPA(6))
      CLON=REAL(UTPA(5))
      CRAD=89.999
      GO TO 10036
10037 CONTINUE
      IF (.NOT.(IPRF.EQ.15)) GO TO 10038
      CLAT=REAL(UTPA(6))
      CLON=REAL(UTPA(5))
      CRAD=RTOD*ACOS(REAL(UTPA(1)/(UTPA(1)+UTPA(3))))-.001
      GO TO 10036
10038 CONTINUE
      IF (.NOT.(IPRF.EQ.23)) GO TO 10039
      CLAT=  64.
      CLON=-152.
      CRAD=  29.999
10036 CONTINUE
10039 CONTINUE
      CALL NGGCOG (CLAT,CLON,CRAD,TLAT,TLON,361)
      CALL MAPITM (TLAT(1),TLON(1),0,
     +                              IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',18).NE.0) RETURN
      DO 10040 I=2,360
      CALL MAPITM (TLAT(I),TLON(I),1,
     +                            IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',19).NE.0) RETURN
10040 CONTINUE
      CALL MAPITM (TLAT(361),TLON(361),2,
     +                              IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',20).NE.0) RETURN
      CALL MAPIQM (                 IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',21).NE.0) RETURN
      GO TO 108
10034 CONTINUE
      IF (.NOT.(IPRF.EQ.20)) GO TO 10041
      ALPH=.017453292519943*(180.-REAL(UTPA(4)))
      CALL MAPTRN ( 90.,0.,XANP,YANP)
      IF (ICFELL('MAPBLA',22).NE.0) RETURN
      CALL MAPTRN (-90.,0.,XAS1,YAS1)
      IF (ICFELL('MAPBLA',23).NE.0) RETURN
      UNS1=(XAS1-XANP)*COS(ALPH)+(YAS1-YANP)*SIN(ALPH)
      VNS1=(YAS1-YANP)*COS(ALPH)-(XAS1-XANP)*SIN(ALPH)
      XAS2=XANP+VNS1*SIN(ALPH)+UNS1*COS(ALPH)
      YAS2=YANP+UNS1*SIN(ALPH)-VNS1*COS(ALPH)
      DIST=SQRT((XAS2-XAS1)*(XAS2-XAS1)+(YAS2-YAS1)*(YAS2-YAS1))
      IF (.NOT.(VNS1.LT.0.)) GO TO 10042
      DEPS=-.001*DIST
      GO TO 10043
10042 CONTINUE
      DEPS=+.001*DIST
10043 CONTINUE
      DIST=2.*DIST
      XCR(1)=XAS1-DIST*COS(ALPH)+DEPS*SIN(ALPH)
      YCR(1)=YAS1-DIST*SIN(ALPH)-DEPS*COS(ALPH)
      XCR(2)=XAS1+DIST*COS(ALPH)+DEPS*SIN(ALPH)
      YCR(2)=YAS1+DIST*SIN(ALPH)-DEPS*COS(ALPH)
      CALL ARDRLN (IAM,XCR,YCR,2,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',24).NE.0) RETURN
      XCR(1)=XAS2-DIST*COS(ALPH)-DEPS*SIN(ALPH)
      YCR(1)=YAS2-DIST*SIN(ALPH)+DEPS*COS(ALPH)
      XCR(2)=XAS2+DIST*COS(ALPH)-DEPS*SIN(ALPH)
      YCR(2)=YAS2+DIST*SIN(ALPH)+DEPS*COS(ALPH)
      CALL ARDRLN (IAM,XCR,YCR,2,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLA',25).NE.0) RETURN
      GO TO 108
10041 CONTINUE
      GO TO 108
C
C Lambert conformal conic.
C
  101 DLAT=GRDR
      RLON=PHOC+179.9999
      K=CLING(180./DLAT)
      DO 10044 I=1,2
      RLAT=-90.
      CALL MAPITM (RLAT,RLON,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',26).NE.0) RETURN
      DO 10045 J=1,K-1
      RLAT=RLAT+DLAT
      CALL MAPITM (RLAT,RLON,1,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',27).NE.0) RETURN
10045 CONTINUE
      RLAT=RLAT+DLAT
      CALL MAPITM (RLAT,RLON,2,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',28).NE.0) RETURN
      RLON=PHOC-179.9999
10044 CONTINUE
      L10019=    5
      GO TO 10019
10046 CONTINUE
      GO TO 108
C
C Orthographic (or satellite-view).
C
  102 CONTINUE
      IF (.NOT.(ABS(SALT).LE.1..OR.ALFA.EQ.0.)) GO TO 10047
      URAD=1.
      RVTU=1.
      GO TO 106
10047 CONTINUE
      SSLT=SALT
      SALT=-ABS(SALT)
      IF (.NOT.(IROD.EQ.0)) GO TO 10048
      R=.9998
10049 CONTINUE
      IPEN=0
      DO 10050 I=1,361
      RCOSB=COS(DTOR*REAL(I-1))
      RSINB=SIN(DTOR*REAL(I-1))
      IF (.NOT.(R.LT.1.)) GO TO 10051
      RCOSA=(R*R*ABS(SALT)+SSMO*SQRT(1.-R*R))/(R*R+SSMO)
      GO TO 10052
10051 CONTINUE
      S=2.-R
      RCOSA=(S*S*ABS(SALT)-SSMO*SQRT(1.-S*S))/(S*S+SSMO)
10052 CONTINUE
      RSINA=SQRT(1.-RCOSA*RCOSA)
      RSINPH=RSINA*RSINB
      RCOSPH=RCOSA*RCSO-RSINA*RSNO*RCOSB
      RCOSLA=SQRT(RSINPH*RSINPH+RCOSPH*RCOSPH)
      IF (.NOT.(RCOSLA.NE.0.)) GO TO 10053
      RSINPH=RSINPH/RCOSLA
      RCOSPH=RCOSPH/RCOSLA
10053 CONTINUE
      IF (.NOT.(ABS(RSNO).GT.1.E-4)) GO TO 10054
      RSINLA=(RCOSA-RCOSLA*RCOSPH*RCSO)/RSNO
      GO TO 10055
10054 CONTINUE
      RSINLA=RSINA*RCOSB
10055 CONTINUE
      RLAT=RTOD*ATAN2(RSINLA,RCOSLA)
      RLON=PHOC+RTOD*ATAN2(RSINA*RSINB,
     +                     RCOSA*RCSO-RSINA*RSNO*RCOSB)
      IF (ABS(RLON).GT.180.) RLON=RLON-SIGN(360.,RLON)
      CALL MAPITM (RLAT,RLON,IPEN,
     +             IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',29).NE.0) RETURN
      IPEN=1
      IF (I.EQ.360) IPEN=2
10050 CONTINUE
      L10019=    6
      GO TO 10019
10056 CONTINUE
      IF (R.EQ.1.0002) GO TO 10057
      R=1.0002
      GO TO 10049
10057 CONTINUE
      GO TO 10058
10048 CONTINUE
      DSALT=DBLE(ABS(SALT))
      DSSMO=DSALT*DSALT-1.D0
      DR=.9998D0
10059 CONTINUE
      IPEN=0
      DO 10060 I=1,361
      DCOSB=COS(DBLE(DTOR*REAL(I-1)))
      DSINB=SIN(DBLE(DTOR*REAL(I-1)))
      IF (.NOT.(DR.LT.1.D0)) GO TO 10061
      DCOSA=(DR*DR*DSALT+DSSMO*SQRT(1.D0-DR*DR))/
     +                             (DR*DR+DSSMO)
      GO TO 10062
10061 CONTINUE
      DS=2.D0-DR
      DCOSA=(DS*DS*DSALT-DSSMO*SQRT(1.D0-DS*DS))/
     +                             (DS*DS+DSSMO)
10062 CONTINUE
      DSINA=SQRT(1.D0-DCOSA*DCOSA)
      DSINPH=DSINA*DSINB
      DCOSPH=DCOSA*DCSO-DSINA*DSNO*DCOSB
      DCOSLA=SQRT(DSINPH*DSINPH+DCOSPH*DCOSPH)
      IF (.NOT.(DCOSLA.NE.0.D0)) GO TO 10063
      DSINPH=DSINPH/DCOSLA
      DCOSPH=DCOSPH/DCOSLA
10063 CONTINUE
      IF (.NOT.(ABS(DSNO).GT.1.D-4)) GO TO 10064
      DSINLA=(DCOSA-DCOSLA*DCOSPH*DCSO)/DSNO
      GO TO 10065
10064 CONTINUE
      DSINLA=DSINA*DCOSB
10065 CONTINUE
      RLAT=RTOD*REAL(ATAN2(DSINLA,DCOSLA))
      RLON=PHOC+RTOD*REAL(ATAN2(DSINA*DSINB,
     +                    DCOSA*DCSO-DSINA*DSNO*DCOSB))
      IF (ABS(RLON).GT.180.) RLON=RLON-SIGN(360.,RLON)
      CALL MAPITM (RLAT,RLON,IPEN,
     +             IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',30).NE.0) RETURN
      IPEN=1
      IF (I.EQ.360) IPEN=2
10060 CONTINUE
      L10019=    7
      GO TO 10019
10066 CONTINUE
      IF (DR.EQ.1.0002D0) GO TO 10067
      DR=1.0002D0
      GO TO 10059
10067 CONTINUE
10058 CONTINUE
      SALT=SSLT
      GO TO 108
C
C Lambert equal-area.  Note:  The constant "1.999999500000" is the real
C effective radius of the limb of the Lambert equal area projection, as
C determined by the test at statement number 106 in the routine MAPTRN.
C
  103 URAD=1.999999500000
      RVTU=1.
      GO TO 106
C
C Azimuthal equidistant.  Note:  The constant "3.140178439909" is the
C real effective radius of the limb of the azimuthal equidistant
C projection, as determined by the test at statement number 108 in the
C routine MAPTRN.
C
  104 URAD=3.140178439909
      RVTU=1.
      GO TO 106
C
C Mollweide.
C
  105 URAD=2.
      RVTU=0.5
C
  106 IF (ELPF.AND.ABS(UCEN).LT.1.E-4.AND.
     +             ABS(VCEN).LT.1.E-4.AND.
     +             ABS(URNG-URAD).LT.1.E-4.AND.
     +             ABS(VRNG/URNG-RVTU).LT.1.E-4) GO TO 108
C
      TEMP=.9998
C
10068 CONTINUE
      IVIS=-1
      I = 1
      GO TO 10071
10069 CONTINUE
      I =I +1
10071 CONTINUE
      IF (I .GT.(361)) GO TO 10070
      UCIR=TEMP*URAD*COS(DTOR*REAL(I-1))
      VCIR=TEMP*URAD*SIN(DTOR*REAL(I-1))
      U=UCIR
      V=RVTU*VCIR
      IF (.NOT.(.NOT.ELPF.AND.(U.LT.UMIN.OR.U.GT.UMAX.OR.V.LT.VMIN.OR.V.
     +GT.VMAX))) GO TO 10072
      IF (.NOT.(IVIS.EQ.1)) GO TO 10073
      CALL MAPTRP (UOLD,VOLD,U,V,UEDG,VEDG)
      XCRD=UEDG
      YCRD=VEDG
      L10010=    6
      GO TO 10010
10074 CONTINUE
10073 CONTINUE
      IVIS=0
      GO TO 10075
10072 CONTINUE
      IF (.NOT.(ELPF.AND.(((U-UCEN)/URNG)**2+((V-VCEN)/VRNG)**2.GT.1.)))
     +GO TO 10076
      IF (.NOT.(IVIS.EQ.1)) GO TO 10077
      CALL MAPTRE (UOLD,VOLD,U,V,UEDG,VEDG)
      XCRD=UEDG
      YCRD=VEDG
      L10010=    7
      GO TO 10010
10078 CONTINUE
10077 CONTINUE
      IVIS=0
      GO TO 10075
10076 CONTINUE
      IF (.NOT.(IVIS.LT.0)) GO TO 10079
      XCRD=U
      YCRD=V
      L10005=    3
      GO TO 10005
10080 CONTINUE
      IVIS=1
      GO TO 10081
10079 CONTINUE
      IF (.NOT.(IVIS.EQ.0)) GO TO 10082
      IF (.NOT.ELPF) CALL MAPTRP (U,V,UOLD,VOLD,UOLD,VOLD)
      IF (     ELPF) CALL MAPTRE (U,V,UOLD,VOLD,UOLD,VOLD)
      XCRD=UOLD
      YCRD=VOLD
      L10005=    4
      GO TO 10005
10083 CONTINUE
      IVIS=1
10082 CONTINUE
      XCRD=U
      YCRD=V
      L10010=    8
      GO TO 10010
10084 CONTINUE
10081 CONTINUE
10075 CONTINUE
      UOLD=U
      VOLD=V
      GO TO 10069
10070 CONTINUE
      L10019=    8
      GO TO 10019
10085 CONTINUE
      IF (TEMP.EQ.1.0002) GO TO 10086
      TEMP=1.0002
      GO TO 10068
10086 CONTINUE
      GO TO 108
C
C Cylindrical equidistant, Mercator, or Robinson.
C
  107 TEMP=.9998
C
10087 CONTINUE
      IVIS=-1
      RLAT=-90.
      RLON=-180.
      I = 1
      GO TO 10090
10088 CONTINUE
      I =I +1
10090 CONTINUE
      IF (I .GT.(361)) GO TO 10089
      IF (.NOT.(IPRJ.EQ.7.OR.IPRJ.EQ.11)) GO TO 10091
      U=TEMP*RLON
      V=TEMP*RLAT
      GO TO 10092
10091 CONTINUE
      IF (.NOT.(IPRJ.EQ.8.OR.IPRJ.EQ.12)) GO TO 10093
      U=TEMP*DTOR*RLON
      V=TEMP*LOG(TAN((MAX(-89.9999,
     +                MIN(+89.9999,RLAT))+90.)*DTRH))
      GO TO 10092
10093 CONTINUE
      U=TEMP*(RLON/180.)*RBGLEN(RLAT)
      V=TEMP*RBGDFE(RLAT)
10092 CONTINUE
      IF (.NOT.(.NOT.ELPF.AND.(U.LT.UMIN.OR.U.GT.UMAX.OR.V.LT.VMIN.OR.V.
     +GT.VMAX))) GO TO 10094
      IF (.NOT.(IVIS.EQ.1)) GO TO 10095
      CALL MAPTRP (UOLD,VOLD,U,V,UEDG,VEDG)
      XCRD=UEDG
      YCRD=VEDG
      L10010=    9
      GO TO 10010
10096 CONTINUE
10095 CONTINUE
      IVIS=0
      GO TO 10097
10094 CONTINUE
      IF (.NOT.(ELPF.AND.(((U-UCEN)/URNG)**2+((V-VCEN)/VRNG)**2.GT.1.)))
     +GO TO 10098
      IF (.NOT.(IVIS.EQ.1)) GO TO 10099
      CALL MAPTRE (UOLD,VOLD,U,V,UEDG,VEDG)
      XCRD=UEDG
      YCRD=VEDG
      L10010=   10
      GO TO 10010
10100 CONTINUE
10099 CONTINUE
      IVIS=0
      GO TO 10097
10098 CONTINUE
      IF (.NOT.(IVIS.LT.0)) GO TO 10101
      XCRD=U
      YCRD=V
      L10005=    5
      GO TO 10005
10102 CONTINUE
      IVIS=1
      GO TO 10103
10101 CONTINUE
      IF (.NOT.(IVIS.EQ.0)) GO TO 10104
      IF (.NOT.ELPF) CALL MAPTRP (U,V,UOLD,VOLD,UOLD,VOLD)
      IF (     ELPF) CALL MAPTRE (U,V,UOLD,VOLD,UOLD,VOLD)
      XCRD=UOLD
      YCRD=VOLD
      L10005=    6
      GO TO 10005
10105 CONTINUE
      IVIS=1
10104 CONTINUE
      XCRD=U
      YCRD=V
      L10010=   11
      GO TO 10010
10106 CONTINUE
10103 CONTINUE
10097 CONTINUE
      UOLD=U
      VOLD=V
      GO TO 10088
10089 CONTINUE
      L10019=    9
      GO TO 10019
10107 CONTINUE
      IF (TEMP.EQ.1.0002) GO TO 10108
      TEMP=1.0002
      GO TO 10087
10108 CONTINUE
C
C Restore the color index and dash pattern.
C
  108 CALL MAPCHM (-4,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',31).NE.0) RETURN
C
C If the selected outline type is "NONE", quit; no outlines need to
C be drawn.
C
      IF (NOUT.LE.0) RETURN
C
C Set the flag IWGF to say whether or not the whole globe is shown by
C the current projection.  If so (IWGF=1), there's no need to waste the
C time required to check each outline point group for intersection with
C the window.
C
      IWGF=0
      IF (BLAM-SLAM.GT.179.9999.AND.BLOM-SLOM.GT.359.9999) IWGF=1
C
C IGIS keeps track of changes in the group identifier, so that the
C color index can be changed when necessary.
C
      IGIS=0
C
C Position to the user-selected portion of the outline dataset.
C
      CALL MAPIO (1)
      IF (ICFELL('MAPBLM',32).NE.0) RETURN
      NSEG=0
C
C Read the next record (group of points).
C
  301 CALL MAPIO (2)
      IF (ICFELL('MAPBLM',33).NE.0) RETURN
      NSEG=NSEG+1
C
C Check for the end of the desired data.
C
      IF (NPTS.EQ.0) GO TO 303
C
C If less than the whole globe is shown by the projection, do a quick
C check for intersection of the box surrounding the point group with
C the area shown.
C
      IF (.NOT.(IWGF.EQ.0)) GO TO 10109
      IF (SLAG.GT.BLAM.OR.BLAG.LT.SLAM) GO TO 301
      IF ((SLOG     .GT.BLOM.OR.BLOG     .LT.SLOM).AND.
     +    (SLOG-360..GT.BLOM.OR.BLOG-360..LT.SLOM).AND.
     +    (SLOG+360..GT.BLOM.OR.BLOG+360..LT.SLOM)) GO TO 301
10109 CONTINUE
C
C See if the user wants to omit this point group.
C
      CALL HLUMAPEOD (NOUT,NSEG,IDOS(NOUT)+IDLS,
     +                          IDOS(NOUT)+IDRS,NPTS,PNTS)
      IF (ICFELL('MAPBLM',34).NE.0) RETURN
      IF (NPTS.LE.1) GO TO 301
C
C If we've switched to a new group, set the color index, dotting, and
C dash pattern for the group.
C
      IF (.NOT.(IGID.NE.IGIS)) GO TO 10110
      IF (.NOT.(IGIS.NE.0)) GO TO 10111
      CALL MAPCHM (-4-IGIS,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',35).NE.0) RETURN
10111 CONTINUE
      CALL MAPCHM (4+IGID,IOR(ISHIFT(32767,1),1),
     +                              IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',36).NE.0) RETURN
      IGIS=IGID
10110 CONTINUE
C
C Plot the group.
C
      CALL MAPITM (PNTS(1),PNTS(2),0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',37).NE.0) RETURN
C
      DO 10112 K=2,NPTS-1
      CALL MAPITM (PNTS(2*K-1),PNTS(2*K),1,
     +             IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',38).NE.0) RETURN
10112 CONTINUE
C
      CALL MAPITM (PNTS(2*NPTS-1),PNTS(2*NPTS),2,
     +             IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',39).NE.0) RETURN
C
C Force a buffer dump.
C
      L10019=   10
      GO TO 10019
10113 CONTINUE
C
C Go get another group.
C
      GO TO 301
C
C Reset the color index, dotting, and dash pattern, if necessary.
C
  303 CONTINUE
      IF (.NOT.(IGIS.NE.0)) GO TO 10114
      CALL MAPCHM (-4-IGIS,0,IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',40).NE.0) RETURN
10114 CONTINUE
C
C Done.
C
      RETURN
C
C The following internal procedure is invoked to start a line.
C
10005 CONTINUE
      IF (.NOT.(NCRA.GT.1)) GO TO 10115
      CALL ARDRLN (IAM,XCRA,YCRA,NCRA,
     +             XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',41).NE.0) RETURN
10115 CONTINUE
      XCRA(1)=XCRD
      YCRA(1)=YCRD
      NCRA=1
      GO TO (10004,10013,10080,10083,10102,10105) , L10005
C
C The following internal procedure is invoked to continue a line.
C
10010 CONTINUE
      IF (.NOT.(NCRA.EQ.100)) GO TO 10116
      CALL ARDRLN (IAM,XCRA,YCRA,NCRA,
     +             XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',42).NE.0) RETURN
      XCRA(1)=XCRA(100)
      YCRA(1)=YCRA(100)
      NCRA=1
10116 CONTINUE
      NCRA=NCRA+1
      XCRA(NCRA)=XCRD
      YCRA(NCRA)=YCRD
      GO TO (10009,10014,10015,10016,10017,10074,10078,10084,10096,10100
     +,10106) , L10010
C
C The following internal procedure is invoked to terminate a line.
C
10019 CONTINUE
      IF (.NOT.(NCRA.GT.1)) GO TO 10117
      CALL ARDRLN (IAM,XCRA,YCRA,NCRA,
     +             XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (ICFELL('MAPBLM',43).NE.0) RETURN
      NCRA=0
10117 CONTINUE
      GO TO (10018,10024,10029,10033,10046,10056,10066,10085,10107,10113
     +) , L10019
C
      END
