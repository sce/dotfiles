" This file requires "runtime vim.d/nvim-cmp.vim"
"
" $ yarn global add vscode-langservers-extracted
" $ export PATH=$PATH:~/.yarn/bin

lua <<EOF
  -- Set up lspconfig and autocomplete:
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  --Enable (broadcasting) snippet capability for completion
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require('lspconfig')['biome'].setup { capabilities = capabilities }

  require('lspconfig')['cssls'].setup { capabilities = capabilities }
  -- require('lspconfig')['eslint'].setup {}
  require('lspconfig')['html'].setup { capabilities = capabilities }
  require('lspconfig')['jsonls'].setup { capabilities = capabilities }
EOF
