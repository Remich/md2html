# md2html

This is a [pandoc](https://pandoc.org/)-wrapper for hassle-free conversion of Markdown files written in bash.  

You can create and define your own custom themes.  
Comes with an enhanced version of [github-pandoc.css](https://gist.github.com/Dashed/6714393#file-github-pandoc-css).  

It also comes with a launcher script, which converts and opens your Markdown files in one go.  
No need for a separate Markdown reader, since probably everyone already has a webbrowser on his system.  

## Source Files

See source files for more documentation.

### convert-one-md-file-to-html.sh

Convert one Markdown file to HTML5.  

### convert-md-files-to-html.sh

Convert one or more Markdown files to HTML5.  

### launch-md.sh

Convert the supplied Markdown file to a temporary HTML5 file, open it with a program of your choice.  
Deletes the temporary HTML5 file once it is not used anymore.  

## CONFIGURATION

See `themes/github/CONFIG.sh` for configuration options.

### Using Custom Themes

Put custom themes in `themes`.  
See `themes/github` on how to use themes.  

### Enhanced [github-pandoc.css](https://gist.github.com/Dashed/6714393#file-github-pandoc-css)

Added support for a responsive Table-of-Content in a fixed sidebar on the left side of the screen.  

## LICENSE

Released unter the [GPL](http://www.gnu.org/copyleft/gpl.html), version 3 or greater.  
