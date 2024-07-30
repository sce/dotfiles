"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc universally useful behaviour
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Where to create backups, if turned on:
" Try current directory first, or global cache dir as fallback:
set backupdir=.,~/.cache/vim/backup

" Where to store swap files:
" Try current directory first, or global cache dir as fallback:
set directory=.,~/.cache/vim

 " ask what to do when quitting in a limbo state instead of just complaining
set confirm

" check for changes when changing a buffer
" https://vi.stackexchange.com/questions/444/how-do-i-reload-the-current-file
au FocusGained,BufEnter * :checktime
