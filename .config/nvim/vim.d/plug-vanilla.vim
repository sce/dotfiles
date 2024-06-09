"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This file is inteded to run INSIDE a `plug#begin` block.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Startup Screen:
  " set runtimepath+=,~/.vim
  " Config: runtime config/startify.vim
  Plug 'mhinz/vim-startify'

" Treesitter:
  " Config: runtime vim.d/treesitter.vim
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Treesitter Enabled Color Scheme:
  " Config: runtime vim.d/material.vim
  Plug 'marko-cerovac/material.nvim'

" Neovim LSP:
  " Config: runtime vim.d/nvim-lsp.vim
  Plug 'neovim/nvim-lspconfig'

" Neovim Autocomplete:
  " Config: runtime vim.d/nvim-cmp.vim
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'

  " lsp/vscode snippets needed by nvim-cmp:
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'

" Telescope:
  " Config: runtime vim.d/telescope.vim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  " fzf-native requires make, cmake and gcc
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  " Plug 'nvim-telescope/telescope-ui-select.nvim'
  Plug 'LukasPietzschmann/telescope-tabs'
  Plug 'debugloop/telescope-undo.nvim'

" File Explorer:
  " Config: runtime vim.d/neo-tree.vim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-neo-tree/neo-tree.nvim'

" Git:
  " Config: runtime vim.d/telescope.vim
  " telescope-git-file-history requires vim-fugitive:
  Plug 'tpope/vim-fugitive'
  Plug 'isak102/telescope-git-file-history.nvim'

  " Config: runtime vim.d/gitsigns.vim
  Plug 'lewis6991/gitsigns.nvim'

" IDE:
  " Config: runtime vim.d/trouble.vim
  Plug 'folke/trouble.nvim'
