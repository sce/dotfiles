"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source: https://github.com/MunifTanjim/prettier.nvim
"
"   Plug 'neovim/nvim-lspconfig'
"   Plug 'jose-elias-alvarez/null-ls.nvim'
"   Plug 'MunifTanjim/prettier.nvim'
"
"   Adds :Prettier command.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua<<EOF
  local prettier = require("prettier")
  prettier.setup({
    -- bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
    -- filetypes = {
    --   "css",
    --   "graphql",
    --   "html",
    --   "javascript",
    --   "javascriptreact",
    --   "json",
    --   "less",
    --   "markdown",
    --   "scss",
    --   "typescript",
    --   "typescriptreact",
    --   "yaml",
    -- },
  })
EOF
