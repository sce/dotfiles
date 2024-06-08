"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source: https://github.com/jose-elias-alvarez/null-ls.nvim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua<<EOF
  -- Needed by prettier.nvim and eslint.nvim
  -- Archived; should be replaced by none-ls.nvim instead.
  require("null-ls").setup({
    root_dir = require('lspconfig.util').root_pattern('yarn.lock')
  })
EOF
