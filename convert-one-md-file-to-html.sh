#!/bin/bash

# Converts exactly one Markdown file to a HTML5 file using `pandoc`.

# Usage: convert-one-md-file-to-html.sh INPUT [-o OUTPUT] [-p PATH]

# A second argument (-o OUTPUT) can be supplied, which specifies the output file. If no output file is specified the converted document will have the same name as the input file, except for the file extension.

# A third argument (-p PATH) can be supplied, which specifies the location of the output. If no PATH is specified the output file will be placed in the directory of the input file.

APPPATH="$HOME/software/md2html"

# load Config.sh
. $APPPATH/CONFIG.sh

# check for correct number of arguments
if [[ $# -gt 5 ]]; then
	( >&2 echo "ERROR: Too many arguments in $(basename $0).
Usage: $(basename $0) INPUT [-o OUTPUT] [-p PATH]" )
	exit 1
fi

# parse arguments
i=1
anz=$(( $# + 1 ))
output=""
input=""
path=""
while [ "$i" -lt "$anz" ]; do

	case $1 in
	'--output' | '-o')
		
		# shift arguments by 1
		i=$(( $i + 1 ))
		shift 1
		
		output="$1"
		
		# shift arguments by 1
		i=$(( $i + 1 ))
		shift 1
		
		continue
	;;
	'--path' | '-p')
		
		# shift arguments by 1
		i=$(( $i + 1 ))
		shift 1
		
		path="$1"
		
		# shift arguments by 1
		i=$(( $i + 1 ))
		shift 1
		
		continue
	;;
	*)
		input="$1"	
	;;
	esac

	# shift arguments by 1
	i=$(( $i + 1 ))
	shift 1
done

# check for input file
if [[ $input == "" ]]; then
	( >&2 echo "ERROR: Missing argument \"INPUT\" in $(basename $0).
Usage: $(basename $0) INPUT [-o OUTPUT] [-p PATH]" )
	exit 1
fi

# decide which name for the output file to use
if [[ $output == "" ]]; then
	nameout=$(basename -s ".md" "$input")
	nameout="$nameout.html"
else
	nameout="$output"
fi

# decide which path to use
if [[ $path == "" ]]; then
	pathout=$(dirname "$input")
else
	pathout="$path"
fi

options=""

# build string of pandoc options
if [[ ${CFG[tableofcontents]} = true ]]; then
	options="$options --toc"
fi

if [[ ${CFG[standalone]} = true ]]; then
	options="$options --standalone"
fi

if [[ ${CFG[self-contained]} = true ]]; then
	options="$options --self-contained"
fi

if [[ ${CFG[mathjax]} = true ]]; then
	options="$options --mathjax"
fi

# build string of CSS files
css=""
for i in ${CSS[*]}; do
	css="$css --css=$APPPATH/styles/$i"
done

# convert
pandoc $options $css --to=html5 "$input" -o "$pathout/$nameout"
	
exit 0
