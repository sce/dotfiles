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
    " Config: runtime vim.d/null-ls.vim
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " Config: runtime vim.d/prettier.vim
    Plug 'MunifTanjim/prettier.nvim'

    " Eslint:
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'jose-elias-alvarez/null-ls.nvim'
    " Plug 'MunifTanjim/eslint.nvim'
call plug#end()

runtime vim.d/vanilla.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript Specific:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime vim.d/nvim-cmp-html.vim
runtime vim.d/nvim-cmp-js.vim

runtime vim.d/null-ls.vim
runtime vim.d/prettier.vim
" runtime vim.d/eslint.vim
