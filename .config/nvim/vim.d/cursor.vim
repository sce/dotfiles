"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance:

set scrolloff=3 " keep some lines of text at the bottom/top when scrolling.
set ruler " always show cursor position
set laststatus=2 " always show status line

set number " add line numbers
" make line numbers relative to current line
" set relativenumber

set cursorline

highlight StatusLine ctermfg=233 ctermbg=white

highlight CursorLine cterm=none ctermbg=233
"highlight CursorLineNr cterm=bold ctermbg=233
highlight CursorLineNr cterm=NONE ctermbg=233 ctermfg=blue

highlight LineNr ctermbg=232
highlight Visual ctermbg=235 cterm=bold

" in order to let the terminal handle the background:
" highlight Normal ctermbg=none
