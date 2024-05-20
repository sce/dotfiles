" This file requires "runtime vim.d/nvim-cmp.vim"

lua <<EOF
  -- Set up lspconfig and autocomplete:
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['gopls'].setup { capabilities = capabilities }
EOF
