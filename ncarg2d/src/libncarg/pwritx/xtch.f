C
C	$Id: xtch.f,v 1.3 2000-08-22 15:05:45 haley Exp $
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
C
      SUBROUTINE XTCH (IPOINT,IPASS,LCNUM)
C
C RETRIEVES CHARACTER DIGITIZATION.
C
C ON ENTRY
C   IND - AN ARRAY CONTAINING 15-BIT UNITS. EACH WORD CONTAINS AS MANY
C         UNITS AS FIT AS A WHOLE INTO ONE WORD ON THIS PARTICULAR
C         IMPLEMENTATION.
C         EACH UNIT REPRESENTS A POINTER INTO THE ARRAY IDD AND AN
C         INDICATION OF THE FORMAT OF THE DATA WHICH CAN BE FOUND THERE.
C         IN EACH UNIT THE 14 BITS TO THE RIGHT REPRESENT THE NUMBER OF
C         THE ENTRY IN THE ARRAY IDD (FOR 60-BIT WORDS) WHERE THE
C         CORRESPONDING DIGITIZATION STARTS.IF THE FIRST BIT TO THE LEFT
C         IS 1 WE EXPECT 12-BIT UNITS IN THE ARRAY IDD, IF IT IS 0 WE
C         EXPECT 6-BIT UNITS IN IDD.
C   IDD-AN ARRAY CONTAINING CHARACTER DIGITIZATIONS. THE DIGITIZATIONS
C       CAN CONSIST OF EITHER 12-BIT OR 6-BIT UNITS. THE DIGITIZATIONS
C       ARE STORED AS A BIT STREAM CROSSING WORD BOUNDARIES IF NECESSARY
C       FOR 60-BIT WORDS THEY START AT THE BEGINNING OF A WORD.
C       THE END OF A DIGITIZATION IS INDICATED BY 2 CONSECUTIVE UNITS
C       WITH ALL BITS 0.
C   IPOINT - AN INTEGER INDICATING THE IPOINT-TH UNIT STORED IN THE
C            ARRAY IND
C   LC - AN ARRAY. ENTRIES CAN HAVE ANY VALUE.
C   IPASS = 2 RETURN DIGITIZATION OF CHARACTER IDENTIFIED BY PARAMETER
C             IPOINT IN ARRAY LC
C         = 1  RETURN ONLY FIRST AND SECOND UNIT OF DIGITIZATION IN
C              LC(1) AND LC(2)
C   LCNUM - ANY VALUE
C
C ON EXIT
C   IDD - UNCHANGED
C   IND - UNCHANGED
C   IPOINT - UNCHANGED
C   IPASS - UNCHANGED
C   LC - IF NO DIGITIZATION FOUND, UNCHANGED
C        OTHERWISE
C        LC(I) CONTAINS THE I-TH UNIT OF THE DIGITIZATION OF THE
C        CHARACTER THAT WE GET WHEN WE RETRIEVE THE IPOIN-TH UNIT IN THE
C        ARRAY IND, INTERPRET THE FIRST BIT TO THE LEFT AS AN INDICATION
C        OF A 12-BIT OR 6-BIT DIGITIZATION AND THE 14 BITS TO THE RIGHT
C        AS THE NUMBER OF THE ENTRY IN THE ARRAY IDD (FOR 60-BIT WORDS)
C        WHERE THE DIGITIZATION OF THE CHARACTER STARTS.
C        NOTICE THAT EACH UNIT GOES THROUGH A TRANSFORMATION BEFORE IT
C        IS STORED IN LC. FROM 6-BIT UNITS 32 IS SUBTRACTED, FROM 12-
C        BIT UNITS 2048 IS SUBTRACTED. ALSO A SPECIAL INDICATOR (-2048)
C        IS PUT INTO LC FOR UNITS WITH ALL BITS ZERO.
C   LCNUM - IF NO DIGITIZATION FOUND, 0
C           OTHERWISE
C           THE NUMBER OF THE ENTRY IN THE ARRAY LC WHICH CONTAINS THE
C           LAST UNIT OF THE DIGITIZATION OF THE CHARACTER.
C           IT CAN ALGORITHMICALLY BE DEFINED AS THE NUMBER OF UNITS
C           WHICH CAN BE ENCOUNTERED BEFORE 2 CONSECUTIVE UNITS WITH
C           ALL 0 UNITS WERE FOUND.  ASSUME THAT THE STARTING POINT WAS
C           FOUND AS DESCRIBED ABOVE WHEN DESCRIBING THE ARRAY LC.
C
C CALLS
C   IAND,ISHIFT,IOR
C
C CALLED BY
C   PWRITX,CCHECK,DCHECK
C
C
C PWRC0 AND PWRC1 ARE FOR COMMUNICATION WITH ROUTINE PWRITX.
C ROUTINE XTCH RECEIVES VALUES IN PWRC0 AND RETURNS VALUES IN PWRC1.
      COMMON /PWRC1/ LC(150)
C
C
C  NOTE THE SIZE OF IDD AND IND MAY BE MODIFED TO CONTAIN THE NUMBER OF
C  ELEMENTS EQUAL TO THE VALUE OF IDDLEN AND INDLEN COMPUTED IN PWRITX.
C
      COMMON/PWRC0/IDD(8625),IND(789)
C
C  MASKING AND OTHER MACHINE DEPENDENT CONSTANTS WHICH MUST BE
C  CALCULATED.
C
      COMMON/PINIT/MASK(4),MASK6(64),MASK12(64),LAST6,LAST12,IBIT15,
     +        MASK14,NUM15U,NBWD
C
C  INITIALIZATION FLAG
C
      COMMON/PINIT1/IFRST
      LOGICAL IFRST
C
C PWRC2 IS FOR COMMUNICATION WITH THE BLOCK DATA.
      COMMON /PWRC2/ INDZER
C
C
C
C MAXUN - ARRAY CONTAINING MAXIMUM NUMBER OF UNITS TO BE RETRIEVED.
      DIMENSION MAXUN(2)
C
C THE NUMBER OF BITS PER POINTER IN THE ARRAY IND.
C
      DATA NBPP /15/
C
C THE NUMBER OF BITS IN A 6-BIT UNIT.
C
      DATA NBPU6 /6/
C
C THE NUMBER OF BITS IN A 12-BIT UNIT.
C
      DATA NBPU12 /12/
C
C FOR 6-BIT UNITS.  LC(I) = I-TH UNIT - IHALF6.
C
      DATA IHALF6 /32/
C
C FOR 12-BIT UNITS.  LC(I) = I-TH UNIT - IHAL12.
C
      DATA IHAL12 /2048/
C
C THE NUMBER OF UNITS TO BE RETRIEVED IF IPASS IS EQUAL TO 1.
C
      DATA MAXUN(1) /2/
C
C THE MAXIMUM NUMBER OF UNITS TO BE RETRIEVED IF IPASS IS 2.
C
      DATA MAXUN(2) /150/
C
C
C
C LOCAL VARIABLES
C
C IDD - ARRAY CONTAINING DIGITIZATIONS OF CHARACTERS.
C IND - ARRAY CONTAINING POINTERS INTO THESE DIGITIZATIONS.
C LC - ARRAY TO CONTAIN THE DIGITIZATION OF 1 CHARACTER, 1 UNIT PER WORD
C IWORD - THE WORD IN THE ARRAY IND CONTAINING THE IPOINT-TH 15 BIT
C         UNIT.
C IPOS - THE IPOS-TH UNIT IN IND(IWORD) IS THE IPOINT-TH UNIT IN THE
C        ARRAY IND.
C IFIFTN - THE IPOINT-TH 15-BIT UNIT.
C IMODE - THE MODE OF THE DIGITIZATION
C         =0  6-BIT MODE
C         =1  12-BIT MODE
C IDIGP - POINTER TO THE START OF THE DIGITIZATION
C NUMMAX - THE MAXIMUM NUMBER OF DIGITIZATION UNITS TO BE RETRIEVED
C BIT - THE NUMBER OF THE BIT IN ARRAY IDD AT WHICH THE DIGITIZATION
C        STARTS
C IDDWOR - WORD IN ARRAY IDD CONTAINING BIT IBIT
C NPOS - POSITION OF BIT IBIT IN WORD IDDWOR
C NRIGHT - NUMBER OF BITS TO THE RIGHT OF BIT NPOS IN WORD + 1
C LCTEM - CONTAINS LEFT PART OF DIGITIZATION UNIT, IF UNIT CROSSES
C         WORD BOUNDARIES
C IDIGP - ENTRY IN THE ARRAY IDD (ASSUMED 60-BIT WORDS) WHERE THE
C         DIGITIZATION STARTS
C         =0  NO DIGITIZATION FOUND
C INDZER - AN INDICATION THAT AN ALL 0 BITS UNIT WAS ENCOUNTERED.
C
C                     INITIALIZATION OF MASKS
C
C  CHECK IF INITIALIZATION ALREADY PERFORMED
C
      IF (IFRST) GO TO 1000
      IFRST = .TRUE.
C
C  GENERATE MASKS AND OTHER MACHINE-DEPENDENT CONSTANTS
C
      CALL MKMSK
C  END INITIALIZATION
 1000 CONTINUE
C
C                  P A R T   1
C FIND IDIGP, ENTRY IN ARRAY IDD WHERE DIGITIZATION OF CHARACTER STARTS.
C FIND IMODE, INDICATION FOR FORMAT OF DIGITIZATION (12-BIT, 6-BIT).
C
C
C INITIALIZE THE NUMBER OF UNITS CONTAINED IN LC TO ZERO.
C
      LCNUM = 0
C
C FIND THE WORD IN THE ARRAY IND WHICH CONTAINS THE IPOINT-TH UNIT.
C
      IWORD = (IPOINT-1)/NUM15U + 1
C
C FIND THE NUMBER OF THE IPOINT-TH UNIT WITHIN THE WORD IWORD.
C
      IPOS = IPOINT - (IWORD-1)*NUM15U
C
C RETRIEVE THE 15-BIT UNIT.
C
      IFIFTN = IAND(MASK(IPOS),IND(IWORD))
C
C SHIFT THE 15-BIT UNIT TO THE RIGHT END OF THE WORD.
C
      IFIFTN = ISHIFT(IFIFTN,IPOS*NBPP-NBWD)
C
C RETRIEVE THE MODE OF THE DIGITIZATION POINTED TO.
C
      IMODE = IAND(IFIFTN,IBIT15)
      IF (IMODE .NE. 0) IMODE = 1
C
C RETRIEVE THE NUMBER OF THE ENTRY IN THE IDD ARRAY WHERE THE
C DIGITIZATION STARTS.
C
      IDIGP = IAND (IFIFTN,MASK14)
C
C RETURN IF NO DIGITIZATION EXISTS FOR THIS POINTER.
C
      IF (IDIGP .EQ. 0) RETURN
C
C                  P A R T   2
C STORE DIGITIZATION OF CHARACTER INTO ARRAY LC, 1 UNIT PER WORD.
C
C
C DEFINE THE MAXIMUM NUMBER OF UNITS TO BE RETRIEVED.
C
      NUMMAX = MAXUN(IPASS)
C
C BRANCH DEPENDING ON FORMAT OF DIGITIZATION.
C
      IMODE = IMODE + 1
      GOTO (1,2), IMODE
C
C 6-BIT FORMAT.
C
    1 CONTINUE
C
C FIND THE BIT WHERE THE DIGITIZATION OF THE CHARACTER STARTS.
      BIT = FLOAT((IDIGP-1)*60+1)
      IDDWOR = IFIX(BIT/FLOAT(NBWD)) + 1
      NPOS = IFIX(BIT - FLOAT(IDDWOR-1)*FLOAT(NBWD))
C
C LOOP FOR MAXIMUM NUMBER OF UNITS OR UNTIL END OF DIGITIZATION REACHED.
      DO 11 I = 1,NUMMAX
C INCREMENT THE NUMBER OF UNITS STORED IN LC.
      LCNUM = LCNUM + 1
C STORE UNIT INTO LC(I), RIGHT JUSTIFIED.
      LC(I) = IAND(IDD(IDDWOR),MASK6(NPOS))
      NRIGHT = NBWD - NPOS + 1
      LC(I) = ISHIFT(LC(I),NBPU6-NRIGHT)
C
C *** THIS PART IS ONLY FOR MACHINES WHERE NBWD CANNOT BE DIVIDED BY 6
      IF (NRIGHT .GE. NBPU6) GOTO 10
      LCTEM = IAND (IDD(IDDWOR),MASK6(NPOS))
      LCTEM = ISHIFT(LCTEM,NBPU6-NRIGHT)
      LC(I) = IAND(IDD(IDDWOR+1),MASK6(1))
      LC(I) = ISHIFT(LC(I),NBPU6-NRIGHT-NBWD)
      LSTORE = NBWD-NBPU6+NRIGHT+1
      LC(I) = IAND(LC(I),MASK6(LSTORE))
      LC(I) = IOR(LC(I),LCTEM)
   10 CONTINUE
C *** END OF PART FOR NBWD NOT DIVIDABLE BY 6
C
      LC(I) = IAND(LAST6,LC(I))
C INTERPRET UNIT AS POSITIVE OR NEGATIVE DISPLACEMENT.
      LC(I) = LC(I) - IHALF6
C IF THIS UNIT HAS ALL ZERO BITS, SET INDICATOR.
      IF (LC(I) .EQ. -IHALF6) LC(I) = INDZER
C THE FOLLOWING CHECK CAN ONLY BE DONE FOR I GREATER THAN 1.
      IF (I .EQ. 1) GOTO 100
C CHECK FOR END OF DIGITIZATION (2 ALL ZERO UNITS IN A ROW).
      IF (LC(I) .EQ. INDZER .AND. LC(I-1) .EQ. INDZER) GOTO 3
C DEFINE THE NEXT DIGITIZATION UNIT.
  100 CONTINUE
      NPOS = NPOS + NBPU6
      IF (NPOS .LT. NBWD) GOTO 101
      IDDWOR = IDDWOR + 1
      NPOS = NPOS - NBWD
  101 CONTINUE
C
   11 CONTINUE
      GOTO 3
C
C
C 12-BIT FORMAT.
C
C ALGORITHM EXACTLY AS FOR 6-BIT FORMAT
    2 CONTINUE
      BIT = FLOAT((IDIGP-1)*60+1)
      IDDWOR = IFIX(BIT/FLOAT(NBWD)) + 1
      NPOS = IFIX(BIT - FLOAT(IDDWOR-1)*FLOAT(NBWD))
      DO 21 I = 1,NUMMAX
      LCNUM = LCNUM + 1
      LC(I) = IAND(IDD(IDDWOR),MASK12(NPOS))
      NRIGHT = NBWD - NPOS + 1
      LC(I) = ISHIFT(LC(I),NBPU12-NRIGHT)
C
C *** THIS PART IS ONLY FOR MACHINES WHERE NBWD CANNOT BE DIVIDED BY 12
      IF (NRIGHT .GE. NBPU12) GOTO 20
      LCTEM = IAND (IDD(IDDWOR),MASK12(NPOS))
      LCTEM = ISHIFT(LCTEM,NBPU12-NRIGHT)
      LC(I) = IAND(IDD(IDDWOR+1),MASK12(1))
      LC(I) = ISHIFT(LC(I),NBPU12-NRIGHT-NBWD)
      LSTORE = NBWD-NBPU12+NRIGHT+1
      LC(I) = IAND(LC(I),MASK12(LSTORE))
      LC(I) = IOR(LC(I),LCTEM)
   20 CONTINUE
C *** END OF PART FOR NBWD NOT DIVIDABLE BY 12 ***
C
      LC(I) = IAND(LAST12,LC(I))
      LC(I) = LC(I) - IHAL12
      IF (LC(I) .EQ. -IHAL12) LC(I) = INDZER
      IF (I .EQ. 1) GOTO 200
      IF (LC(I) .EQ. INDZER .AND. LC(I-1) .EQ. INDZER) GOTO 3
  200 CONTINUE
      NPOS = NPOS + NBPU12
      IF (NPOS .LT. NBWD) GOTO 201
      IDDWOR = IDDWOR + 1
      NPOS = NPOS - NBWD
  201 CONTINUE
   21 CONTINUE
C
C
    3 CONTINUE
C
      RETURN
      END
