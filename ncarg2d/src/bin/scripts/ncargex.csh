#!/bin/csh -f
#
#   $Id: ncargex.csh,v 1.33 1993-04-12 16:03:55 haley Exp $
#

#********************#
#                    #
#   NCARGEX USAGE    #
#                    #
#********************#
if ($#argv < 1) then
  echo "usage: ncargex [-all,-A] [-allexamples,-E] [-alltests,-T]        "
  echo "               [-allfundamental,-F] [-alltutorial,-U] [-areas]   "
  echo "               [-autograph] [-bivar] [-colconv] [-conpack]       "
  echo "               [-conran_family] [-conrec_family] [-dashline]     "
  echo "               [-ezmap] [-field_flow] [-gflash] [-gridall]       "
  echo "               [-halftone] [-histogram] [-isosrfhr] [-isosurface]"
  echo "               [-labelbar] [-ngmisc] [-plotchar] [-pwrite_family]"
  echo "               [-scrolled_title] [-softfill] [-spps]             "
  echo "               [-streamlines] [-surface] [-threed] [-vectors]    "
  echo "               [-gks] [-misc] [-clean] [-n] [-onebyone] names    "
  echo "                                                                 "
  echo "See <man ncargex>                                                "
  exit
endif

#*********************************#
#                                 #
# Check for existing directories  #
#                                 #
#*********************************#
set example_dir=`ncargpath SED_EXAMPLESDIR`
if ($status != 0) then
        exit 1
endif

if (! -d "$example_dir") then
  echo "Example directory <$example_dir> does not exist."
  exit 1
endif
set fund_dir = $example_dir
set pdoc_dir = $example_dir

set test_dir=`ncargpath SED_TESTSDIR`
if ($status != 0) then
  exit 1
endif

if (! -d "$test_dir") then
  echo "Test directory <$test_dir> does not exist."
  exit 2
endif

set tutor_dir=`ncargpath SED_TUTORIALDIR`
if ($status != 0) then
  exit 1
endif

if (! -d "$tutor_dir") then
  echo "Test directory <$tutor_dir> does not exist."
  exit 2
endif

#**********************#
#                      #
#  Set areas examples  #
#                      #
#**********************#
set ex_areas   = (arex01)
set tst_areas  = (tareas)
set ttr_areas  = (cardb1 caredg carline cardb2 carfill carmap)
set areas_list = ($ex_areas $tst_areas $ttr_areas)

#**************************#
#                          #
#  Set autograph examples  #
#                          #
#**************************#
set ex_autograph   = (agex01 agex02 agex03 agex04 agex05 agex06 agex07 \
                      agex08 agex09 agex10 agex11 agex12 agex13)
set tst_autograph  = (tautog tagupw)
set fnd_autograph  = (fagaxclr fagaxlbl fagaxmax fagcuclr fagcudsh fagezmxy \
                      fagezmy fagezxy fagezy fagilclr fagovrvw)
set autograph_list = ($ex_autograph $tst_autograph $fnd_autograph)

#******************************#
#                              #
#  Set bivar/conpack examples  #
#                              #
#******************************#
set ex_cbivar   = (cbex01)
set ttr_cbivar  = (cidsfft)
set cbivar_list = ($ex_cbivar $ttr_cbivar)

#************************#
#                        #
#  Set colconv examples  #
#                        #
#************************#
set tst_colconv  = (tcolcv)
set fnd_colconv  = (fcce01 fcce02)
set colconv_list = ($tst_colconv $fnd_colconv)

#************************#
#                        #
#  Set conpack examples  #
#                        #
#************************#
set ex_conpack   = (cpex01 cpex02 cpex03 cpex04 cpex05 cpex06 cpex07 \
                    cpex08 cpex09 ${ex_cbivar})
set tst_conpack  = (tconpa)
set ttr_conpack  = (ccpback ccpcff ccpcfx ccpcica ccpcir ccpcis ccpcit ccpclc \
                    ccpcld ccpcldm ccpcldr ccpcll ccpclu ccpcnrc ccpdflt \
                    ccpezct ccpfil ccpga ccphand ccphcf ccphl ccphlt ccpila \
                    ccpils ccpilt ccpklb ccplbam ccplbdr ccpline ccpllb \
                    ccpllc ccplll ccpllo ccpllp ccpllt ccpllw ccpmap \
                    ccpmovi ccpmpxy ccpncls ccpnet ccpnof ccpnsd ccppc ccppc1 \
                    ccppc2 ccppc3 ccppc4 ccppkcl ccpt2d ccprc ccprect ccprwc \
                    ccprwu ccpscam ccpset ccpsps1 ccpsps2 ccpspv ccptitle \
                    ccpvp ccpvs colcon ${ttr_cbivar})
set conpack_list = ($ex_conpack $tst_conpack $ttr_conpack)

#******************************#
#                              #
#  Set conran_family examples  #
#                              #
#******************************#
set tst_cnrn_family  = (tconan tconaq tconas)
set cnrn_family_list = (${tst_cnrn_family})

#******************************#
#                              #
#  Set conrec_family examples  #
#                              #
#******************************#
set tst_cnrc_family  = (tconre tcnqck tcnsmt tcnsup)
set cnrc_family_list = (${tst_cnrc_family})

#*************************#
#                         #
#  Set dashline examples  #
#                         #
#*************************#
set tst_dashline  = (tdashc tdashl tdashp tdashs)
set fnd_dashline  = (fdlcurvd fdldashc fdldashd fdlsmth)
set dashline_list = ($tst_dashline $fnd_dashline)

#**********************#
#                      #
#  Set ezmap examples  #
#                      #
#**********************#
set ex_ezmap   = (mpex01 mpex02 mpex03 mpex04 mpex05 mpex06 mpex07 mpex08 \
                  mpex09 mpex10 mpexfi eezmpa)
set tst_ezmap  = (tezmap tezmpa)
set ttr_ezmap  = (cezmap1 cezmap2 cezmap3 cmpclr cmpdd cmpdrw cmpel \
                  cmpfil cmpgci cmpgrd cmpgrp cmpita cmpitm cmplab cmplbl \
                  cmplot cmpmsk cmpou cmppos cmpsat cmpsup cmptit cmptra \
                  cmpusr)
set ezmap_list = ($ex_ezmap $tst_ezmap $ttr_ezmap)

#***********************#
#                       #
#  Set gflash examples  #
#                       #
#***********************#
set tst_gflash  = (tgflas)
set gflash_list = ($tst_gflash)

#************************#
#                        #
#  Set gridall examples  #
#                        #
#************************#
set tst_gridall  = (tgrida)
set gridall_list = ($tst_gridall)

#*************************#
#                         #
#  Set halftone examples  #
#                         #
#*************************#
set tst_halftone  = (thafto)
set halftone_list = ($tst_halftone)

#**************************#
#                          #
#  Set histogram examples  #
#                          #
#**************************#
set tst_histogram  = (thstgr)
set histogram_list = ($tst_histogram)

#***********************#
#                       #
# set isosrfhr examples #
#                       #
#***********************#
set tst_isosrfhr  = (tisohr)
set isosrfhr_list = ($tst_isosrfhr)

#*************************#
#                         #
# set isosurface examples #
#                         #
#*************************#
set tst_isosurface  = (tisosr tpwrzi)
set fnd_isosurface  = (fiseziso fisissrf fispwrzi)
set isosurface_list = ($tst_isosurface $fnd_isosurface)

#***********************#
#                       #
# set labelbar examples #
#                       #
#***********************#
set ex_labelbar   = (elblba)
set tst_labelbar  = (tlblba)
set labelbar_list = ($ex_labelbar $tst_labelbar)

#*********************#
#                     #
# set ngmisc examples #
#                     #
#*********************#
set fnd_ngmisc  = (fngngdts fngwsym)
set ngmisc_list = ($fnd_ngmisc)

#***********************#
#                       #
# set plotchar examples #
#                       #
#***********************#
set ex_plotchar   = (epltch)
set tst_plotchar  = (tpltch)
set fnd_plotchar  = (fpchiqu fpcloqu fpcfonts)
set plotchar_list = ($ex_plotchar $tst_plotchar $fnd_plotchar)

#****************************#
#                            #
# set pwrite_family examples #
#                            #
#****************************#
set tst_pwrite  = (tpwrtx tpwry)
set pwrite_list = ($tst_pwrite)

#*****************************#
#                             #
# set scrolled title examples #
#                             #
#*****************************#
set ex_scrlld_title   = (slex01)
set tst_scrlld_title  = (tstitl)
set fnd_scrlld_title  = (fslfont)
set scrlld_title_list = (${ex_scrlld_title} ${tst_scrlld_title} \
                         ${fnd_scrlld_title})

#***********************#
#                       #
# set softfill examples #
#                       #
#***********************#
set ex_softfill   = (sfex01 sfex02)
set tst_softfill  = (tsoftf)
set fnd_softfill  = (fsfwrld fsfsgfa)
set softfill_list = ($ex_softfill $tst_softfill $fnd_softfill)

#*******************#
#                   #
# set spps examples #
#                   #
#*******************#
set ex_spps   = (splogy sprevx spset1 spset2)
set fnd_spps  = (fspcurve fspline fsppoint fspponts)
set spps_list = ($ex_spps $fnd_spps)

#**************************#
#                          #
# set streamlines examples #
#                          #
#**************************#
set ex_streamlines   = (stex01 stex02 stex03)
set tst_streamlines  = (tstrml)
set fnd_streamlines  = (fstream ffex00 ffex01 ffex03 ffex04)
set streamlines_list = ($ex_streamlines $tst_streamlines \
                        $fnd_streamlines)

#**********************#
#                      #
# set surface examples #
#                      #
#**********************#
set ex_surface   = (srex01)
set tst_surface  = (tsrfac tpwrzs)
set fnd_surface  = (fsrezsrf fsrpwrzs fsrsrfac)
set surface_list = ($ex_surface $tst_surface $fnd_surface)

#*********************#
#                     #
# set threed examples #
#                     #
#*********************#
set tst_threed  = (tthree tpwrzt)
set fnd_threed  = (fthex01 fthex02 fthex03 fthex04 fthex05)
set threed_list = ($tst_threed $fnd_threed)

#**********************#
#                      #
# set vectors examples #
#                      #
#**********************#
set ex_vectors   = (vvex01 vvex02)
set tst_vectors  = (tvelvc)
set fnd_vectors  = (ffex00 ffex01 ffex02 ffex05)
set vectors_list = ($ex_vectors $tst_vectors $fnd_vectors)

#****************************************#
#                                        #
#  Set field flow examples - consists of #
#  all streamlines and vectors examples  #
#                                        #
#****************************************#
set ex_field   = (stex01 stex02 stex03 vvex01 vvex02)
set tst_field  = (tstrml tvelvc)
set fnd_field  = (ffex00 ffex01 ffex02 ffex03 ffex04 ffex05)
set field_list = ($ex_field $tst_field $fnd_field)

#******************#
#                  #
# set gks examples #
#                  #
#******************#
set fnd_gks    = (fgke02 fgke03 fcell fcell0 fgpm01 fgkgpl fgkgpm fgkgtx \
                  fgklnclr fgklnwth)
set fnd_intgks = (fgke01 fgke04)
set pdc_gks    = (pgkex01 pgkex02 pgkex03 pgkex04 pgkex05 pgkex06 pgkex07 \
                  pgkex08 pgkex09 pgkex10 pgkex11 pgkex12 pgkex13 pgkex14 \
                  pgkex15 pgkex16 pgkex17 pgkex18 pgkex19 pgkex20 pgkex21)
set gks_list   = ($fnd_gks $pdc_gks)

#****************************#
#                            #
# set miscellaneous examples #
#                            #
#****************************#
set ex_misc   = (coex01 coex02 coex03 example bnchmk)
set fnd_misc  = (fcoord fcoord1 fcoord2)
set misc_list = ($ex_misc $fnd_misc)

#*************************************************************#
#                                                             #
# Some of the other examples are considered tutorial examples #
#                                                             #
#*************************************************************#
set ttr_overlap = (mpex03 mpex05 arex01 sfex01 tsoftf)

#*********************************************************************#
#                                                                     #
#               SET LISTS OF VARIOUS TYPES OF EXAMPLES                #
#                                                                     #
#*********************************************************************#
set ex_list  = ($ex_areas $ex_autograph $ex_conpack $ex_ezmap $ex_field \
                $ex_labelbar $ex_plotchar ${ex_scrlld_title} $ex_softfill \
                $ex_spps $ex_surface $ex_misc)

set tst_list = ($tst_areas $tst_autograph $tst_colconv $tst_conpack \
                ${tst_cnrn_family} ${tst_cnrc_family} $tst_dashline \
                $tst_ezmap $tst_field $tst_gflash $tst_gridall $tst_halftone \
                $tst_histogram $tst_isosrfhr $tst_isosurface $tst_labelbar \
                $tst_plotchar $tst_pwrite ${tst_scrlld_title} \
                $tst_softfill $tst_surface $tst_threed)

set ttr_list = ($ttr_areas $ttr_conpack $ttr_ezmap)

set fnd_list = ($fnd_autograph $fnd_colconv $fnd_dashline $fnd_field $fnd_gks \
                $fnd_isosurface $fnd_ngmisc $fnd_plotchar ${fnd_scrlld_title} \
                $fnd_softfill $fnd_spps $fnd_surface $fnd_threed $fnd_misc)

set pdc_list = ($pdc_gks)

#*********************************#
#                                 #
# Default is to load in X library #
#                                 #
#*********************************#
set X11_option

#***************#
#               #
# Parse options #
#               #
#***************#
set names

while ($#argv > 0)
    
    switch ($1)

        case "-all":
        case "-A":
            shift
            set names=($ex_list $tst_list $ttr_list $fnd_list $pdoc_list)
            breaksw

        case "-allexamples":
        case "-E":
            shift
            set names=($ex_list)
            breaksw

        case "-alltests":
        case "-T":
            shift
            set names=($tst_list)
            breaksw
        
        case "-alltutorial":
        case "-U":
            shift
            set names=($ttr_list $ttr_overlap)
            breaksw
        
        case "-allfundamental":
        case "-F":
            shift
            set names=($fnd_list)
            breaksw
        
        case "-allpdocexamples":
        case "-P":
            shift
            set names=($pdc_list)
            breaksw
        
        case "-areas":
            shift
            set names=($areas_list)
            breaksw
        
        case "-autograph":
            shift
            set names=($autograph_list)
            breaksw

        case "-bivar":
            shift
            set names=($cbivar_list)
            breaksw

        case "-colconv":
            shift
            set names=($colconv_list)
            breaksw

        case "-conpack":
            shift
            set names=($conpack_list)
            breaksw

        case "-conran_family":
            shift
            set names=(${cnrn_family_list})
            breaksw

        case "-conrec_family":
            shift
            set names=(${cnrc_family_list})
            breaksw

        case "-dashline":
            shift
            set names=($dashline_list)
            breaksw

        case "-ezmap":
            shift
            set names=($ezmap_list)
            breaksw

        case "-field_flow":
            shift
            set names=($field_list)
            breaksw

        case "-gflash":
            shift
            set names=($gflash_list)
            breaksw

        case "-gridall":
            shift
            set names=($gridall_list)
            breaksw

        case "-halftone":
            shift
            set names=($halftone_list)
            breaksw

        case "-histogram":
            shift
            set names=($histogram_list)
            breaksw

        case "-isosrfhr":
            shift
            set names=($isosrfhr_list)
            breaksw

        case "-isosurface":
            shift
            set names=($isosurface_list)
            breaksw

        case "-labelbar":
            shift
            set names=($labelbar_list)
            breaksw

        case "-ngmisc":
            shift
            set names=($ngmisc_list)
            breaksw

        case "-plotchar":
            shift
            set names=($plotchar_list)
            breaksw

        case "-pwrite_family":
            shift
            set names=($pwrite_list)
            breaksw

        case "-scrolled_title":
            shift
            set names=(${scrlld_title_list})
            breaksw

        case "-softfill":
            shift
            set names=($softfill_list)
            breaksw

        case "-spps":
            shift
            set names=($spps_list)
            breaksw

        case "-streamlines":
            shift
            set names=($streamlines_list)
            breaksw

        case "-surface":
            shift
            set names=($surface_list)
            breaksw

        case "-threed":
            shift
            set names=($threed_list)
            breaksw

        case "-vectors":
            shift
            set names=($vectors_list)
            breaksw

        case "-gks":
            shift
            set names=($gks_list)
            breaksw

        case "-misc":
            shift
            set names=($misc_list)
            breaksw

        case "-clean":
            shift
            set CleanOption
            breaksw

        case "-n":
            shift
            set NoRunOption
            breaksw
        
        case "-onebyone":
            shift
            set OneByOneOption
            breaksw

        case "-unique"
            shift
            set Unique
            breaksw

        case "-noX11"
            shift
            set X11_option = "-noX11"
            breaksw

        case "-list"
            shift
            set List
            breaksw

        case "-*":
            echo "$0 : Unknown option <$1>"
            exit 1
            breaksw

        default:
            set names=($names $1)
            shift
            breaksw
    endsw
end


#***********************#
#                       #
# Generate each example #
#                       #
#***********************#
foreach name ($names)

set rmfiles

#*************************************#
#                                     #
# Find out what type of example it is #
#                                     #
#*************************************#
set type="Unknown"

foreach known ($ex_list)
    if ("$name" == "$known") then
        set type="Example"
    endif
end

foreach known ($tst_list)
    if ("$name" == "$known") then
        set type="Test"
    endif
end

foreach known ($ttr_list)
    if ("$name" == "$known") then
        set type="Tutorial"
    endif
end

foreach known ($fnd_list)
    if ("$name" == "$known") then
        set type="Fundamentals"
    endif
end

foreach known ($fnd_intgks)
    if ("$name" == "$known") then
        set type="Fundamentals"
    endif
end

foreach known ($pdc_list)
    if ("$name" == "$known") then
        set type="Programmer"
    endif
end

#***********************************************#
#                                               #
# If you just want to see what list of examples #
# you have asked for, list them and exit        #
#                                               #
#***********************************************#
if ($?List) then
   echo $names
   exit
endif

#**************************#
#                          #
# Find out what type it is #
#                          #
#**************************#

switch ($type)
    case Example:
        echo "NCAR Graphics Fortran Example <$name>"
    breaksw

    case Test:
        echo "NCAR Graphics Fortran Test <$name>"
    breaksw
    
    case Fundamentals:
        echo "NCAR Graphics Fortran Fundamentals Example <$name>"
    breaksw

    case Tutorial:
        echo "NCAR Graphics Fortran Tutorial Example <$name>"
    breaksw

    case Programmer:
        echo "NCAR Graphics Fortran Programmer Doc Example <$name>"
    breaksw

    case Unknown:
        echo "ncargex: <$name> is not a known example"
        goto theend
    breaksw
endsw
echo ""

#**************************************************#
#                                                  #
# If the "-unique" option was selected and the     #
# example already exists, don't generate it again. #
#                                                  #
#**************************************************#

if ($?Unique && -f $name.ncgm) goto theend

#********************************#
#                                #
# Code for handling all examples #
#                                #
#********************************#

set ncargf77flags
set f_files = $name.f
set rmfiles

#****************************************#
#                                        #
# Some examples need extra Fortran files #
#                                        #
#****************************************#

switch ($name)
    case cpex01:
    case cpex02:
    case cpex03:
    case cpex04:
    case cpex05:
    case cpex06:
    case cpex07:
    case cpex08:
    case cpex09:
        set f_files = ($f_files cpexcc.f)
        set rmfiles = (cpexcc.o)
    breaksw

    case mpex01:
    case mpex02:
    case mpex03:
    case mpex04:
    case mpex05:
    case mpex06:
    case mpex07:
    case mpex08:
    case mpex09:
    case mpex10:
    case mpexfi:
        set f_files = ($f_files mpexcc.f)
        set rmfiles = (mpexcc.o)
    breaksw

    case vvex01:
    case vvex02:
        set f_files = ($f_files vvexcc.f)
        set rmfiles = (vvexcc.o)
    breaksw

    case ccpcir:
    case ccpcnrc:
    case ccpezct:
    case ccphl:
    case ccpmap:
    case ccpvp:
        set f_files = ($f_files ggdini.f)
        set rmfiles = (ggdini.o)
    breaksw
endsw

set copy_files = "$f_files"

switch ($name)

#*******************************#
#                               #
# Some examples need data files #
#                               #
#*******************************#

    case mpexfi:
        set copy_files = ($copy_files mpexfi.dat)
    breaksw

    case srex01:
        set copy_files = ($copy_files srex01.dat)
    breaksw

    case agex13:
        set copy_files = ($copy_files agda13.dat)
    breaksw

    case ffex02:
    case ffex03:
        set copy_files = ($copy_files ffex02.dat)
    breaksw

    case ffex05:
        set copy_files = ($copy_files ffex05.dat)
    breaksw

    case ccpmpxy:
        set copy_files = ($copy_files cpmpxy1.dat cpmpxy2.dat)
    breaksw

    case ccpila:
    case ccpt2d:
        set copy_files = ($copy_files ccpila.dat)
    breaksw

    case ccpils:
    case ccpilt:
    case ccplbdr:
    case ccptitle:
        set copy_files = ($copy_files ccpex.dat)
    breaksw


#**********************************************************#
#                                                          #
# Set special ncargf77 flags for some of the test examples #
#                                                          #
#**********************************************************#

# quick routines
    case tdashl:
    case tcnqck:
    case tconaq:
        set ncargf77flags = "-quick"
    breaksw

# smooth routines (default)
    case tdashs:
    case tcnsmt:
    case tconan:
        set ncargf77flags = "-smooth"
    breaksw

# super routines
    case tdashp:
    case tcnsup:
    case tconas:
    case fdlsmth:
        set ncargf77flags = "-super"
    breaksw

# autograph with pwritx for character generation
    case tagupw:
        set ncargf77flags = "-agupwrtx"
    breaksw
endsw

set rmfiles = ($rmfiles $copy_files)

#***********************#
#                       #
# Copy the needed files #
#                       #
#***********************#
   
foreach file($copy_files)
    echo "  Copying $file"
    if ( $type == "Example")      cp $example_dir/$file .
    if ( $type == "Fundamentals") cp $fund_dir/$file .
    if ( $type == "Programmer")   cp $pdoc_dir/$file .
    if ( $type == "Tutorial" )    cp $tutor_dir/$file .
    if ( $type == "Test" )        cp $test_dir/$file .
end

#******************************#
#                              #
# Compile and link the example #
#                              #
#******************************#
   
if (! $?NoRunOption) then
    echo ""
    echo "Compiling and Linking..."
    ncargf77 $X11_option $ncargf77flags -o $name $f_files
    if ($status != 0) then
        echo ""
        echo "The compile and link failed"
        exit -1
    endif
    echo ""
    echo "Executing <$name>..."

#*****************#
#                 #
# Run the example #
#                 #
#*****************#
   
    switch( $name )
        case mpexfi:
            ncargrun -o $name.ncgm $name < mpexfi.dat
        breaksw
        case srex01:
            ncargrun -o $name.ncgm $name < srex01.dat
        breaksw
        case agex13:
            ncargrun -o $name.ncgm $name < agda13.dat
        breaksw
        case ffex02:
        case ffex03:
            ncargrun -o $name.ncgm $name < ffex02.dat
        breaksw
        case ffex05:
            ncargrun -o $name.ncgm $name < ffex05.dat
        breaksw
        case fgke03:
            $name
            echo "Metafiles META01 and META02 produced"
        breaksw
        case ccpcff:
            ncargrun -o $name.ncgm $name
            /bin/rm -f $name.ncgm
            echo "No metafile produced"
        breaksw
        case tcolcv:
            $name
            echo "No metafile produced"
        breaksw
        default:
            ncargrun -o $name.ncgm $name
    endsw

    set rmfiles = ($rmfiles $name.o $name)
    if ( $name != "tcolcv" && $name != "ccpcff" && $name != "fgke03" ) then
        echo "Metafile is named $name.ncgm"
    endif
endif

#******************************#
#                              #
# Keep track of unwanted files #
#                              #
#******************************#
switch ($name)
    case ccpmovi
        set rmfiles = ($rmfiles GNFB00)
    breaksw

    case slex01:
        set rmfiles = ($rmfiles GNFB09)
    breaksw

    case fgke02:
        set rmfiles = ($rmfiles GNFB01 GNFB02)
    breaksw

    case tgflas:
        set rmfiles = ($rmfiles GNFB01 GNFB02 GNFB03 GNFB04)
    breaksw

    case tstitl:
        set rmfiles = ($rmfiles GNFB09)
    breaksw
endsw

endif


#************************#
#                        #
# Remove unwanted files. #
#                        #
#************************#

if ($?CleanOption) then
    rm -f $rmfiles
endif

#************************#
#                        #
# Display NCGM on screen #
#                        #
#************************#
if ($?OneByOneOption && (-f $name.ncgm)) then
    ctrans -d X11 -geometry 1142x865+10+0 $name.ncgm
    rm -f $name.ncgm $rmfiles
endif

theend:

end

