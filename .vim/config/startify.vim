"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Startify:
"
" https://github.com/mhinz/vim-startify
" https://github.com/mhinz/vim-startify/blob/master/doc/startify.txt
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_fortune_use_unicode = 1

" sort sessions by modification time true/false:
let g:startify_session_sort = 1

" automatically persist session when closing vim or loading a new session
let g:startify_session_persistence = 1

" Don't automatically change to root because sometimes we don't want that.
let g:startify_change_to_vcs_root = 0

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'dir',       'header': ['   Most recently used files in '. getcwd()] },
      \ { 'type': 'files',     'header': ['   Most recently used files']            },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
