" https://neovim.io/doc/user/nvim.html#nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Proper keybindings using ALT:
map <A-e> :tabedit<CR>
map <A-l> :tabnext<CR>
map <A-h> :tabprevious<CR>

" Remove vim bindings that use escape instead of alt:
unmap <esc>e
unmap <esc>l
unmap <esc>h
