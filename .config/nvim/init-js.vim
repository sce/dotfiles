" init-js.vim
" set verbose=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/js/plugged')
  " Startup screen:
  Plug 'mhinz/vim-startify'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " treesitter enabled color scheme:
  Plug 'marko-cerovac/material.nvim'

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

  " Telescope:
  Plug 'nvim-lua/plenary.nvim'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  " File explorer:
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-neo-tree/neo-tree.nvim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/cursor.vim
runtime vim.d/indent-2.vim
runtime vim.d/move.vim
runtime vim.d/search.vim

set runtimepath+=,~/.vim

runtime config/startify.vim

runtime vim.d/nvim-cmp.vim
runtime vim.d/nvim-cmp-js.vim
runtime vim.d/nvim-cmp-html.vim

" runtime vim.d/nvim-tree.vim
runtime vim.d/material.vim

runtime vim.d/telescope.vim

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}

nnoremap <leader>e <cmd>Neotree filesystem reveal right toggle dir=%:p:h<cr>
