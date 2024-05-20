" init-go.vim
" set verbose=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/go/plugged')

  " Go setup from https://github.com/ray-x/go.nvim :
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'neovim/nvim-lspconfig'

  " guihua recommended for floating window support:
  Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }

  " LSP GUI:
  Plug 'ray-x/navigator.lua'

  Plug 'ray-x/go.nvim'

  " Other setup
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'morhetz/gruvbox' " vim color scheme gruvbox

  " Neovim LSP autocomplete:
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  " lsp/vscode snippets needed by nvim-cmp:
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
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

runtime vim.d/nvim-cmp.vim
runtime vim.d/nvim-cmp-go.vim

" No need for require('lspconfig'), navigator will configure it for you.
" Actually looks like nvim-cmp is automatically picked up too.
lua <<EOF
  require('navigator').setup()
  require('go').setup()
EOF

" :TSInstall go " for treesitter golang
" :GoInstallBinaries
