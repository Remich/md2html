#!/bin/bash

# Usage: launch-md.sh FILE

# Converts the supplied FILE to a temporary html file,
# opens it in a new instance of firefox 
# and deletes the temporary file once the firefox instance closes.

APPPATH="$HOME/software/md2html"
SRCPATH="$APPPATH/src"
USAGE=$'\nUsage: '$(basename $0)' FILE'
ERR=$'ERROR in '$(basename $0)':'

# Defines which application should be used to open the temporary html file.
# NOTE: If using firefox and firefox is already running, you have to start a new separate session. Otherwise firefox throws an error. This probably also applies to other webbrowsers.
HTMLVIEWER="firefox -no-remote -P mdh2tml"

if [[ $# -eq 0 ]]; then
	( >&2 echo "$ERR Missing argument FILE. $USAGE" )
	exit 1
fi

if [[ $# -gt 1 ]]; then
	( >&2 echo "$ERR Too many arguments. $USAGE" )
	exit 1
fi

if [[ ! -f "$1" ]]; then
	( >&2 echo "$ERR File '$1' does not exist. $USAGE" )
	exit 1
fi

# create temporary file
tmpfile=$(mktemp /tmp/launch-md-XXXXXX.html)
trap "rm -f $tmpfile" 0 2 3 15

# convert it
path="$(dirname $tmpfile)"
name="$(basename $tmpfile)"
$SRCPATH/convert-one-md-file-to-html.sh "$1" -o "$name" -p "$path" && $HTMLVIEWER "$tmpfile" &

# wait
pid=$!
wait $pid

exit 0
