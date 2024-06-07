"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This File: init-vanilla.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set verbose=2
set verbose=1

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/vanilla/plugged')
  runtime vim.d/plug-vanilla.vim
call plug#end()

runtime vim.d/vanilla.vim
