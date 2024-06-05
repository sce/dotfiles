"
" native lsp setup
"

nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>

" 'l' prefix for lsp
nnoremap <leader>lf <cmd>lua vim.lsp.buf.format()<cr>
nnoremap K <cmd>lua vim.lsp.buf.hover()<cr>

" language server capabilities:
nnoremap <leader>lc <cmd>lua =vim.lsp.get_active_clients()[1].server_capabilities<cr>
