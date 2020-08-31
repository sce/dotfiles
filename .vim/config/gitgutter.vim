"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   Git Gutter Configuration:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" after you stop typing, trigger plugin after how many ms (default 4000):
let g:gitgutter_realtime = 1000

" have gitgutter update signcolumn highlight group to match sign column background:
" let g:gitgutter_set_sign_backgrounds = 1

" these highlights are relevant for gruvbox (or coc?) since it will pick up
" these colors, maybe:
highlight GitGutterAdd ctermbg=None
highlight GitGutterChange ctermbg=None
highlight GitGutterDelete ctermbg=None
highlight GitGutterDelete ctermbg=None
highlight GitGutterChangeDelete ctermbg=None

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" And might as well add git keybindings here too:

map <Leader>d :!git df "%"<CR>
map <Leader>D :!git dc "%"<CR>

map <Leader>w :!git df -w "%"<CR>
map <Leader>W :!git dc -w "%"<CR>

" can't use --patch for merge conflicts for some reason
map <Leader>a :!git add -p "%"<CR>
map <Leader>A :!git add "%"<CR>

map <Leader>N :!git add -N "%"<CR>

map <Leader>r :!git reset "%"<CR>
" map <Leader>R :!git reset<CR>
