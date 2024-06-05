"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init-go.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set verbose=2
set verbose=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/go/plugged')
  runtime vim.d/plug-vanilla.vim

  " guihua recommended for floating window support:
  " Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }

  " LSP GUI:
  " Plug 'ray-x/navigator.lua'
  " Plug 'ray-x/go.nvim'

  " File explorer:
  " Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/vanilla.vim
runtime vim.d/indent-4.vim
" runtime config/fzf.vim
runtime vim.d/nvim-cmp-go.vim
" runtime vim.d/nvim-tree.vim

" No need for require('lspconfig'), navigator will configure it for you.
" Actually looks like nvim-cmp is automatically picked up too.
" lua <<EOF
"   require('navigator').setup()
"   require('go').setup()
" EOF

" :TSInstall go " for treesitter golang
" :GoInstallBinaries
