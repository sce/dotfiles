" init-go.vim
" set verbose=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/go/plugged')
  " Startup screen:
  Plug 'mhinz/vim-startify'

  " Go setup from https://github.com/ray-x/go.nvim :
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " treesitter enabled color scheme:
  Plug 'marko-cerovac/material.nvim'

  " guihua recommended for floating window support:
  " Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }

  " LSP GUI:
  " Plug 'ray-x/navigator.lua'
  " Plug 'ray-x/go.nvim'

  " Telescope:
  Plug 'nvim-lua/plenary.nvim'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

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

  " File explorer:
  Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/cursor.vim
runtime vim.d/indent-4.vim
runtime vim.d/move.vim
runtime vim.d/search.vim

set runtimepath+=,~/.vim

runtime config/startify.vim
" runtime config/fzf.vim

runtime vim.d/nvim-cmp.vim
runtime vim.d/nvim-cmp-go.vim

runtime vim.d/nvim-tree.vim
runtime vim.d/material.vim

runtime vim.d/telescope.vim

" No need for require('lspconfig'), navigator will configure it for you.
" Actually looks like nvim-cmp is automatically picked up too.
" lua <<EOF
"   require('navigator').setup()
"   require('go').setup()
" EOF

" :TSInstall go " for treesitter golang
" :GoInstallBinaries

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
