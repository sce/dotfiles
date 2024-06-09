"
" native lsp setup
"
command LspDoCodeAction      lua vim.lsp.buf.code_action()
command LspDoDeclaration     lua vim.lsp.buf.declaration()
command LspDoDefinition      lua vim.lsp.buf.definition()
command LspDoDiagnostic      lua vim.lsp.buf.diagnostic()
command LspDoDocumentSymbol  lua vim.lsp.buf.document_symbol()
command LspDoFormat          lua vim.lsp.buf.format()
command LspDoHover           lua vim.lsp.buf.hover()
command LspDoImplementation  lua vim.lsp.buf.implementation()
" command LspDoIncomingCalls   lua vim.lsp.buf.incoming_calls()
" command LspDoOutgoingCalls   lua vim.lsp.buf.outgoing_calls()
command LspDoReferences      lua vim.lsp.buf.references()
command LspDoRename          lua vim.lsp.buf.rename()
command LspDoSignatureHelp   lua vim.lsp.buf.signature_help()
command LspDoTypeDefinition  lua vim.lsp.buf.type_definition()
command LspDoWorkspaceSymbol lua vim.lsp.buf.workspace_symbol()

" language server capabilities:
command LspCapabilities1 lua =vim.lsp.get_active_clients()[1].server_capabilities
command LspCapabilities2 lua =vim.lsp.get_active_clients()[2].server_capabilities
command LspCapabilities3 lua =vim.lsp.get_active_clients()[3].server_capabilities

nnoremap K <cmd>LspDoHover<cr>

nnoremap gd <cmd>LspDoDefinition<cr>
nnoremap gD <cmd>LspDoDiagnostic<cr>
nnoremap gi <cmd>LspDoImplementation<cr>
nnoremap gr <cmd>LspDoReferences<cr>
nnoremap gy <cmd>LspDoTypeDefinition<cr>

nnoremap <leader>ca <cmd>LspDoCodeAction<cr>
nnoremap <leader>rn <cmd>LspDoRename<cr>

" p for 'prettier'
nnoremap <leader>p <cmd>LspDoFormat<cr>
xnoremap <leader>p <cmd>LspDoFormat<cr>
