"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This file is inteded to run INSIDE a `plug#begin` block.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Startup screen:
  " set runtimepath+=,~/.vim
  " runtime config/startify.vim
  Plug 'mhinz/vim-startify'

" Treesitter:
  " runtime vim.d/treesitter.vim
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" treesitter enabled color scheme:
  " runtime vim.d/material.vim
  Plug 'marko-cerovac/material.nvim'

" Neovim LSP:
  " runtime vim.d/nvim-lsp.vim
  Plug 'neovim/nvim-lspconfig'

" Neovim autocomplete:
  " runtime vim.d/nvim-cmp.vim
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'

  " lsp/vscode snippets needed by nvim-cmp:
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'

" Telescope:
  " runtime vim.d/telescope.vim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  " Plug 'nvim-telescope/telescope-ui-select.nvim'
  Plug 'LukasPietzschmann/telescope-tabs'

  Plug 'debugloop/telescope-undo.nvim'

" File explorer:
  " runtime vim.d/neo-tree.vim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-neo-tree/neo-tree.nvim'
