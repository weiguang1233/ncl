C
C $Id: mapgtd.f,v 1.5 2008-09-04 19:56:58 kennison Exp $
C
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C The use of this Software is governed by a License Agreement.
C
      SUBROUTINE MAPGTD (WHCH,DVAL)
        CHARACTER*(*)    WHCH
        DOUBLE PRECISION DVAL
        IF (ICFELL('MAPGTD - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
        CALL MDGETD (WHCH,DVAL)
        IF (ICFELL('MAPGTD',2).NE.0) RETURN
        RETURN
      END
