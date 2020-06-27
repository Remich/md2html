#!/bin/bash

# TODO update Usage with theme folder
# Converts exactly one Markdown file to a HTML5 file using `pandoc`.

# Usage: convert-one-md-file-to-html.sh INPUT [-t THEME] [-o OUTPUT] [-p PATH]

# -t THEME
# Specifies a theme. Themes are located in 'themes'. If no THEME is supplied the default (github) will be used.
# -o OUTPUT
# Specifies the name of the output. If no OUTPUT is given the converted document will have the same name as INPUT, except for the file extension.
# -p PATH
# Specifies the location of OUTPUT. If no PATH is given OUTPUT will be placed in the same location where INPUT is located.

APPPATH="$HOME/software/md2html"
SRCPATH="$APPPATH/src"
USAGE=$'\nUsage: '$(basename $0)' INPUT [-o OUTPUT] [-p PATH] [-t THEME]'
ERR=$'ERROR in '$(basename $0)':'

# check for correct number of arguments

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
		
		# check for value
		if [[ $1 == "" ]]; then
			( >&2 echo "$ERR Missing value for argument OUTPUT.$USAGE" )
			exit 1
		fi
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
		
		# check for value
		if [[ $1 == "" ]]; then
			( >&2 echo "$ERR Missing value for argument PATH. $USAGE" )
			exit 1
		fi
		path="$1"
		
		# shift arguments by 1
		i=$(( $i + 1 ))
		shift 1
		
		continue
	;;
	'--theme' | '-t')
		
		# shift arguments by 1
		i=$(( $i + 1 ))
		shift 1
		
		# check for value
		if [[ $1 == "" ]]; then
			( >&2 echo "$ERR Missing value for argument THEME.$USAGE" )
			exit 1
		fi
		theme="$1"
		
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
	( >&2 echo "$ERR Missing argument INPUT. $USAGE" )
	exit 1
fi

# check for theme otherwise set default
if [[ $theme == "" ]]; then
	theme='github'
fi

# set theme folder
THEMEPATH="$APPPATH/themes/$theme"

# check if theme exists
if [[ ! -d $THEMEPATH ]]; then
	( >&2 echo "$ERR Theme '$theme' not found.$USAGE" )
	exit 1
fi


# check if theme CONFIG.sh exists
if [[ ! -f "$THEMEPATH/CONFIG.sh" ]]; then
	( >&2 echo "$ERR Missing 'CONFIG.sh' in theme '$theme'. $USAGE" )
 exit 1
fi

# load CONFIG.sh of theme
. $APPPATH/themes/$theme/CONFIG.sh


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
if [[ ${CFG[template]} != "" ]]; then
	$options="$options --template=${CFG[template]}"
fi
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
	css="$css --css=$THEMEPATH/$i"
done

# convert
pandoc $options $css \
	--to=html5 \
	--smart \
	--section-divs \
	"$input" -o "$pathout/$nameout"
	
exit 0
