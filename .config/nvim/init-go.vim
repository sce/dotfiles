" init-go.vim
" set verbose=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/go/plugged')

  " Go setup from https://github.com/ray-x/go.nvim :
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'neovim/nvim-lspconfig'
  Plug 'ray-x/go.nvim'
  Plug 'ray-x/guihua.lua' " recommended for floating window support

  " Other setup
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'morhetz/gruvbox' " vim color scheme gruvbox

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/cursor.vim
runtime vim.d/indent-4.vim
runtime vim.d/move.vim
runtime vim.d/search.vim

set runtimepath+=,~/.vim

runtime config/fzf.vim
runtime config/gruvbox.vim
