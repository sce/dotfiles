"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Statusline:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
"
" http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'

"set statusline+=%t       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file

"set statusline^=%t\     "tail of the filename
set statusline^=%f\     "filename
set statusline+=%=      "left/right separator
set statusline+=%c      "cursor column
set statusline+=\ %l/%L "cursor line/total lines
set statusline+=\ %P    "percent through file
set statusline+=\ %h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
