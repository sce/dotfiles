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
"let g:startify_change_to_vcs_root = 0
let g:startify_change_to_vcs_root = 1

" https://github.com/mhinz/vim-startify/wiki/Example-configurations
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
" To prevent getting potentially lots of untracked files we cap at 200:
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard | head -n 200 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'dir',       'header': ['   Most recently used files in '. getcwd()] },
      \ { 'type': 'files',     'header': ['   Most recently used files']            },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
      \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
      \ ]
