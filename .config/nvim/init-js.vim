"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This File: init-js.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set verbose=2
set verbose=1

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/js/plugged')
  runtime vim.d/plug-vanilla.vim

  " Javascript Specific:
    " Prettier:
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'MunifTanjim/prettier.nvim'
call plug#end()

runtime vim.d/vanilla.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript Specific:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime vim.d/nvim-cmp-js.vim
runtime vim.d/nvim-cmp-html.vim
runtime vim.d/prettier.vim
