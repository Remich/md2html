#!/bin/bash

# See pandoc documentation for options below.

declare -A CFG

# CSS files
CSS=()
CSS+=('github-pandoc.css')
CSS+=('github-pandoc-enhance.css')

# Template
CFG["template"]=''

# Crate a table of contents.
CFG["tableofcontents"]=true

# Create a standalone html file
CFG["standalone"]=true

# Create a self-contained html file
CFG["self-contained"]=true

# Mathjax support
CFG["mathjax"]=true
