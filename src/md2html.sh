#!/bin/bash

# Convert multiple Markdown files to HTML5 files using `pandoc`.
# Usage: md2html.sh FILE [FILE...]

APPPATH="$HOME/software/md2html"
SRCPATH="$APPPATH/src"
USAGE=$'\nUsage: '$(basename $0)' FILE [FILE...]'
ERR=$'ERROR in '$(basename $0)':'

if [[ $# -eq 0 ]]; then
	( >&2 echo "$ERR Missing argument(s). $USAGE" )
	exit 1
fi

for I in "$@"; do
	$SRCPATH/convert-one-md-file-to-html.sh "$I"	
done

exit 0
