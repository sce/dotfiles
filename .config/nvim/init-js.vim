"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This File: init-js.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set verbose=2
set verbose=1

runtime vim.d/plug.vim

call plug#begin('~/.config/nvim/js/plugged')
  runtime vim.d/plug-vanilla.vim

  " Javascript Specific:
    " Prettier:
    " Config: runtime vim.d/null-ls.vim
    Plug 'nvimtools/none-ls.nvim'
    " Plug 'nvimtools/none-ls-extras.nvim'

    " Config: runtime vim.d/prettier.vim
    Plug 'MunifTanjim/prettier.nvim'

    " Eslint:
    Plug 'neovim/nvim-lspconfig'
    " Plug 'MunifTanjim/eslint.nvim'
    Plug 'mfussenegger/nvim-lint'

    " Instead of copilot.vim:
    Plug 'copilotlsp-nvim/copilot-lsp'
    Plug 'zbirenbaum/copilot.lua'

    " CopilotChat:
    " Config: runtime vim.d/copilot.vim Plug 'nvim-lua/plenary.nvim'
    Plug 'CopilotC-Nvim/CopilotChat.nvim'

    " Autocomplete for Copilot:
    Plug 'zbirenbaum/copilot-cmp'
call plug#end()

runtime vim.d/vanilla.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript Specific:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme material-darker

runtime vim.d/nvim-cmp-html.vim
runtime vim.d/nvim-cmp-js.vim

runtime vim.d/null-ls.vim
runtime vim.d/prettier.vim
" runtime vim.d/eslint.vim

runtime vim.d/copilot.vim
