C
C $Id: mpgddp.f,v 1.3 2000-08-22 15:04:12 haley Exp $
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
      DOUBLE PRECISION FUNCTION MPGDDP (ALAT,ALON,BLAT,BLON)
C
        DOUBLE PRECISION ALAT,ALON,CALT,SALT,CALN,SALN
        DOUBLE PRECISION BLAT,BLON,CBLT,SBLT,CBLN,SBLN
C
        DOUBLE PRECISION XCOA,YCOA,ZCOA
        DOUBLE PRECISION XCOB,YCOB,ZCOB
C
        DOUBLE PRECISION DIST
C
        DOUBLE PRECISION DTOR,RTOD
C
        DATA DTOR / .017453292519943D0 /
        DATA RTOD / 57.2957795130823D0 /
C
        CALT=COS(DTOR*ALAT)
        SALT=SIN(DTOR*ALAT)
        CALN=COS(DTOR*ALON)
        SALN=SIN(DTOR*ALON)
C
        CBLT=COS(DTOR*BLAT)
        SBLT=SIN(DTOR*BLAT)
        CBLN=COS(DTOR*BLON)
        SBLN=SIN(DTOR*BLON)
C
        XCOA=CALT*CALN
        YCOA=CALT*SALN
        ZCOA=SALT
C
        XCOB=CBLT*CBLN
        YCOB=CBLT*SBLN
        ZCOB=SBLT
C
        DIST=SQRT((XCOA-XCOB)**2+(YCOA-YCOB)**2+(ZCOA-ZCOB)**2)
C
        MPGDDP=2.D0*RTOD*ASIN(DIST/2.D0)
C
        RETURN
C
      END
