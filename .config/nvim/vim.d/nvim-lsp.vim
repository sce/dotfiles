"
" native lsp setup
"

nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>

" 'l' for lsp
nnoremap <leader>lf <cmd>lua vim.lsp.buf.format()<cr>
nnoremap <leader>lh <cmd>lua vim.lsp.buf.hover()<cr>

" language server capabilities:
nnoremap <leader>lc <cmd>lua =vim.lsp.get_active_clients()[1].server_capabilities<cr>
