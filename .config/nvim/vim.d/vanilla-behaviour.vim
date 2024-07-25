"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc universally useful behaviour
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" where to create backups, if turned on:
" Let's just create backups in the same directory for now.
" set backupdir=~/.cache/vim/backup
set backupdir=./

" where to store swap files:
" Let's just store swap files in the same directory for now.
" set directory=~/.cache/vim/
set directory=./

 " ask what to do when quitting in a limbo state instead of just complaining
set confirm

" check for changes when changing a buffer
" https://vi.stackexchange.com/questions/444/how-do-i-reload-the-current-file
au FocusGained,BufEnter * :checktime
