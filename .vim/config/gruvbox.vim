"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" activate gruvbox after all plugins are loaded, to make sure it works:
" autocmd vimenter * colorscheme gruvbox
autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox

" gruvbox options must come after setting the colorscheme
let g:gruvbox_contrast_dark = "hard"

" in order to let the terminal handle the background:
autocmd vimenter * highlight Normal ctermbg=none
highlight Normal ctermbg=none
