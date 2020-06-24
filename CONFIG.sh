#!/bin/bash

declare -A CFG

# CSS files
# CSS=("github-pandoc.css" "toc-sidebar.css")
CSS=("tufte.css", "toc-sidebar.css")

# Defines which application should be used to open the temporary html file.
# NOTE: If using firefox and firefox is already running, you have to start a new seperate session. Otherwise firefox throws an error. This probably also applies to other webbrowsers.
CFG["htmlapplication"]='firefox -no-remote -P md2html'

# NOTE: See pandoc documentation for options below.

# Crate a table of contents.
CFG["tableofcontents"]=true

# Create a standalone html file
CFG["standalone"]=true

# Create a self-contained html file
CFG["self-contained"]=true

# Mathjax support
CFG["mathjax"]=true
