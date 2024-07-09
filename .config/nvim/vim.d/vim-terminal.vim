"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://vi.stackexchange.com/questions/17816/solved-ish-neovim-dont-close-terminal-buffer-after-process-exit
"
" Make neovim terminal behave more like vim terminal:
tnoremap <Esc> <C-\><C-n>
au TermOpen  * setlocal nonumber | startinsert
au TermClose * setlocal   number | call feedkeys("\<C-\>\<C-n>")
