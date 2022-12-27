" " Multi-entry selection UI.
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" https://github.com/junegunn/fzf.vim#preview-window
" preview window hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']

" fzf on open buffers
nmap <Leader>b :Buffers<CR>

" fzf on all git files
nmap <Leader>g :GFiles<CR>

" fzf on git files starting from directory of current file
command! -bang GFilesHere call fzf#vim#gitfiles(expand("%:h"), <bang>0)

nmap <leader>G :GFilesHere<cr>

" fzf on all files
nmap <leader>f :FZF<cr>

" fzf ripgrep on all files
nmap <leader>r :Rg<cr>
