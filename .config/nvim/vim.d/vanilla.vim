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
runtime vim.d/vanilla-ui.lua

set runtimepath+=,~/.vim

" ~/.vim/config/startify.vim
runtime config/startify.vim

runtime vim.d/gitsigns.lua
runtime vim.d/treesitter.lua

runtime vim.d/material.lua

runtime vim.d/nvim-lsp.vim
runtime vim.d/bashls.lua

runtime vim.d/vsnip.vim
runtime vim.d/nvim-cmp.lua

runtime vim.d/telescope.vim

runtime vim.d/neo-tree.vim

" runtime vim.d/render-markdown.lua

" runtime vim.d/trouble.vim
runtime vim.d/leap.lua
