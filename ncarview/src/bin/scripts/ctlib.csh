#!/bin/csh -f
#
#	$Id: ctlib.csh,v 1.6 1993-01-20 15:54:27 haley Exp $
#
#
#	This script simply reports the libraries required by ctrans.
#	The library list will vary depending on machine configuration
#

set libdir = `ncargpath LIBDIR`
if ($status != 0) then
	exit 1
endif
if (! -d "$libdir") then
  echo "Library directory <$libdir> does not exist."
  exit 1
endif

set robjdir = $libdir/NCARGDIR/ROBJDIR

set locals = ""

foreach file (CTRANS_ROBJS)
  set locals = "$locals $robjdir/$file"
end

foreach file (CTRANS_LIBS_A)
  set locals = "$locals $libdir/$file"
end

echo $locals CTRANS_LIBS_B
