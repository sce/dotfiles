" " Multi-entry selection UI.
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" fzf on open buffers
map <Leader>b :Buffers<CR>

" fzf on all git files
map <Leader>g :GFiles<CR>

" fzf on all files
map <leader>f :FZF<cr>

" fzf ripgrep on all files
map <leader>r :Rg<cr>
