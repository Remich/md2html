# md2html

This is a [pandoc](https://pandoc.org/)-wrapper for hassle-free conversion of Markdown files written in bash.  

It also comes with a launcher script, which converts and opens your Markdown files in one go.  
No need for a separate Markdown reader, since probably everyone already has a webbrowser on his system.  

## Installation

Clone the repository where you want to.  
Change the variable `APPPATH` to the location where the repository resides.  
Crating some custom symbolic links in your `$PATH` is recommnded.  

## Source Files

See source files for more documentation.

### convert-one-md-file-to-html.sh

Convert one Markdown file to HTML5.  
Usage: `$ convert-one-md-file-to-html.sh INPUT [-o OUTPUT] [-p PATH]`

### convert-md-files-to-html.sh

Convert one or more Markdown files to HTML5.  
Usage: `md-to-html.sh FILE...`

### launch-md.sh

Convert the supplied Markdown file to a temporary HTML5 file, open it with the program specified in `CONFIG.sh`.  
Deletes the temporary HTML5 file once it is not used anymore.  
Usage: `$ launch-md.sh FILE`

## CONFIGURATION

See `CONFIG.sh` for configuration options.

### Using Custom CSS Styles

When using custom CSS styles, put them into the `styles` directory and change `CONFIG.sh` accordingly:  

```bash
CSS=("style1.css" "style2.css")
```

### Modified Table-of-Content for [github-pandoc.css](https://gist.github.com/Dashed/6714393#file-github-pandoc-css)

I personally use the style [github-pandoc.css](https://gist.github.com/Dashed/6714393#file-github-pandoc-css).  
This repository comes with a modification for `github-pandoc.css`. If you want to have the ToC fixed on the left side of the document, add the style `toc-sidebar.css` to your config.  
This only works in combination with `github-pandoc.css`.  

The CSS line in `CONFIG.sh` then should look like this:  

```bash
# CSS files
CSS=("github-pandoc.css" "toc-sidebar.css")
```

## LICENSE

Released unter the [GPL](http://www.gnu.org/copyleft/gpl.html), version 3 or greater.  
