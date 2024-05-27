"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope:
" Plug 'nvim-lua/plenary.nvim'
" Plug 'BurntSushi/ripgrep'
" Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope git_files<cr>
nnoremap <leader>j <cmd>Telescope jumplist<cr>
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap <leader>s <cmd>Telescope spell_suggest<cr>

nnoremap gr <cmd>Telescope grep_string<cr>
nnoremap gR <cmd>Telescope lsp_references<cr>

nnoremap <leader>h <cmd>Telescope highlights<cr>

lua <<EOF
  require('telescope').setup{
    defaults = {
      mappings = {
        -- n = {
        --   ["<esc>"] = require('telescope.actions').close,
        -- },
        i = {
          ["<esc>"] = require('telescope.actions').close,
        },
      }
    }
  }

  -- for telescope-fzf-native:
  require('telescope').load_extension('fzf')
EOF