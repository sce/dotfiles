" https://neovim.io/doc/user/nvim.html#nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Proper keybindings using ALT:
nmap <A-e> :tabedit<CR>
nmap <A-l> :tabnext<CR>
nmap <A-h> :tabprevious<CR>

" Remove vim bindings that use escape instead of alt:
unmap <esc>e
unmap <esc>l
unmap <esc>h

" Quit terminal:
" (ah, this messes up quitting/closing fzf-terminals for some reason)
" tnoremap <esc> <C-\><C-n>
tnoremap <C-A-\> <C-\><C-n>

" move line up/down, like in vscode:
nnoremap <A-up> :m--<cr>
nnoremap <A-down> :m+<cr>

" move selection up/down:
xnoremap <A-up> :m '<-2<cr>gv
xnoremap <A-down> :m '>+1<cr>gv

"xmap <A-up> :m '<-2<cr>gv<Plug>(coc-format-selected)gv
"xmap <A-down> :m '>+1<cr>gv<Plug>(coc-format-selected)gv

" Prevent terminals to close their window/tab by going to normal mode when
" closing:
" https://vi.stackexchange.com/questions/17816/solved-ish-neovim-dont-close-terminal-buffer-after-process-exit
au TermClose * call feedkeys("\<C-\>\<C-n>")
