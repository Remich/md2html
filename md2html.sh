#!/bin/bash

# Convert multiple Markdown files to HTML5 files using `pandoc`.
# Usage: md2html.sh FILE...

APPPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -eq 0 ]]; then
	( >&2 echo "Error: Missing argument(s) \"FILE\" in $(basename $0).
Usage: $(basename $0) FILE..." )
	exit 1
fi

for I in "$@"; do
	$APPPATH/convert-one-md-file-to-html.sh "$I"	
done

exit 0
