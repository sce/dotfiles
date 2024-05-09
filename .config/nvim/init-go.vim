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

call plug#end()
