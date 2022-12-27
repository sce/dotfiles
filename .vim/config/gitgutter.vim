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

nnoremap <Leader>d :term!git df %<CR>i
nnoremap <Leader>D :term!git dc %<CR>i

nnoremap <Leader>w :term!git df -w %<CR>i
nnoremap <Leader>W :term!git dc -w %<CR>i

" can't use --patch formr merge conflicts for some reason
nnoremap <Leader>a :term!git add -p %<CR>i
nnoremap <Leader>A :term!git add %<CR>i

nnoremap <Leader>N :term!git add -N %<CR>i

" map <Leader>r :!git reset %<CR>
" map <Leader>R :!git reset<CR>
