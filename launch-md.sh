#!/bin/bash

# Usage: launch-md.sh FILE

# Converts the supplied FILE to a temporary html file,
# opens it in a new instance of firefox 
# and deletes the temporary file once the firefox instance closes.

APPPATH="$HOME/software/md2html"

if [[ $# -eq 0 ]]; then
	( >&2 echo "ERROR: No INPUT file supplied.
Usage: $(basename $0) INPUT" )
	exit 1
fi

if [[ $# -gt 1 ]]; then
	( >&2 echo "ERROR: Too many arguments.
Usage: $(basename $0) INPUT" )
	exit 1
fi

if [[ ! -f "$1" ]]; then
	( >&2 echo "ERROR: File \"$1\" does not exist." )
	exit 1
fi


# load CONFIG.sh
. "$APPPATH/CONFIG.sh"

# create temporary file
tmpfile=$(mktemp /tmp/launch-md-XXXXXX.html)
trap "rm -f $tmpfile" 0 2 3 15

# convert it
path="$(dirname $tmpfile)"
name="$(basename $tmpfile)"
$APPPATH/convert-one-md-file-to-html.sh "$1" -o "$name" -p "$path" && ${CFG["htmlapplication"]} "$tmpfile" &

# wait
pid=$!
wait $pid

exit 0
