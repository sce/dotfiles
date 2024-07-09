"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vanilla/base/default configuration.
" Some of this matches plugins from vanilla-plug.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Because of bashls we need to add global yarn binaries:
let $PATH=$PATH . ":" . $HOME . "/.yarn/bin"

runtime vim.d/cursor.vim
runtime vim.d/indent-2.vim
runtime vim.d/move.vim
runtime vim.d/search.vim

runtime vim.d/vanilla-commands.vim
runtime vim.d/vanilla-behaviour.vim
runtime vim.d/vim-terminal.vim

set runtimepath+=,~/.vim
"runtime ~/.vim/config/startify.vim
runtime config/startify.vim

runtime vim.d/gitsigns.vim

runtime vim.d/treesitter.vim
runtime vim.d/material.vim

runtime vim.d/nvim-lsp.vim
runtime vim.d/bashls.vim

runtime vim.d/nvim-cmp.vim

runtime vim.d/telescope.vim

runtime vim.d/neo-tree.vim

runtime vim.d/trouble.vim
