C
C $Id: maplot.f,v 1.17 2008-09-04 19:56:58 kennison Exp $
C
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C The use of this Software is governed by a License Agreement.
C
      SUBROUTINE MAPLOT
        IF (ICFELL('MAPLOT - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
        CALL MDPLOT
        IF (ICFELL('MAPLOT',2).NE.0) RETURN
        RETURN
      END
