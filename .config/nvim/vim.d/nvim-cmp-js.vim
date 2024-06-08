" This file requires "runtime vim.d/nvim-cmp.vim"
"
" $ yarn global add typescript typescript-language-server
" $ export PATH=$PATH:~/.yarn/bin

lua <<EOF
  -- Set up lspconfig and autocomplete:
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities,
    root_dir = require('lspconfig.util').root_pattern('yarn.lock')
  }
EOF
