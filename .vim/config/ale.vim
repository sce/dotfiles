"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   Ale Configuration:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_enabled = 1

" The bright red background that ale defaults to is too strong:
highlight ALEError ctermbg=DarkMagenta
highlight ALEError ctermbg=Black

highlight ALEWarning ctermbg=DarkGray
highlight ALEWarning ctermbg=None

" from https://github.com/w0rp/ale/blob/726a768464d3e42869088599cf1bd049f7a751df/README.md
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
"packloadall

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
"silent! helptags ALL
