C
C $Id: maproj.f,v 1.13 2000-08-22 15:03:35 haley Exp $
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
      SUBROUTINE MAPROJ (ARG1,ARG2,ARG3,ARG4)
C
      CHARACTER*(*) ARG1
C
C Declare required common blocks.  See MAPBD for descriptions of these
C common blocks and the variables in them.
C
      COMMON /MAPCM4/ INTF,JPRJ,PHIA,PHIO,ROTA,ILTS,PLA1,PLA2,PLA3,PLA4,
     +                PLB1,PLB2,PLB3,PLB4,PLTR,GRID,IDSH,IDOT,LBLF,PRMF,
     +                ELPF,XLOW,XROW,YBOW,YTOW,IDTL,GRDR,SRCH,ILCW,GRLA,
     +                GRLO,GRPO
      LOGICAL         INTF,LBLF,PRMF,ELPF
      SAVE   /MAPCM4/
C
      COMMON /MAPCM5/ DDCT(5),DDCL(5),LDCT(6),LDCL(6),PDCT(12),PDCL(12)
      CHARACTER*2     DDCT,DDCL,LDCT,LDCL,PDCT,PDCL
      SAVE   /MAPCM5/
C
      COMMON /MAPSAT/ SALT,SSMO,SRSS,ALFA,BETA,RSNA,RCSA,RSNB,RCSB
      SAVE   /MAPSAT/
C
      COMMON /MAPDPS/ DSNA,DCSA,DSNB,DCSB
      DOUBLE PRECISION DSNA,DCSA,DSNB,DCSB
      SAVE   /MAPDPS/
C
C Check for an uncleared prior error.
C
      IF (ICFELL('MAPROJ - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
C
C Transfer the parameters defining the projection.
C
      I=IDICTL(ARG1,PDCT,12)
      IF (I.EQ.0) I=IDICTL(ARG1,PDCL,12)
      IF (I.EQ.0) GO TO 901
C
      JPRJ=I-1
C
      IF (JPRJ.EQ.3) THEN
        CALL MAPSTR ('SA',0.)
        IF (ICFELL('MAPROJ',2).NE.0) RETURN
      ELSE IF (JPRJ.EQ.11) THEN
        JPRJ=3
        IF (ABS(SALT).LE.1.) THEN
          CALL MAPSTR ('SA',6.631)
          IF (ICFELL('MAPROJ',3).NE.0) RETURN
        END IF
      END IF
C
      PHIA=MAX(-90.,MIN(90.,ARG2))
      PHIO=ARG3-SIGN(180.,ARG3+180.)+SIGN(180.,180.-ARG3)
      ROTA=ARG4-SIGN(180.,ARG4+180.)+SIGN(180.,180.-ARG4)
C
C Set the flag to indicate that initialization is now required.
C
      INTF=.TRUE.
C
C Done.
C
      RETURN
C
C Error exit.
C
  901 CALL MAPCEM ('MAPROJ - UNKNOWN PROJECTION NAME ',ARG1,4,1)
      RETURN
C
      END
