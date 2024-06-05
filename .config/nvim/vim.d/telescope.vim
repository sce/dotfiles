"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope:
" Plug 'nvim-lua/plenary.nvim'
" Plug 'BurntSushi/ripgrep'
" Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua<<EOF
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

    -- extensions = {
    --   ["ui-select"] = {
    --     require("telescope.themes").get_dropdown {}
    --   }
    -- }
  }

  -- for telescope-fzf-native:
  require('telescope').load_extension('fzf')

  -- for using telescope instead of ui.select:
  -- require('telescope').load_extension('ui-select')

  -- for searching tabs in telescope:
  require('telescope').load_extension('telescope-tabs')
  require('telescope-tabs').setup {}

  -- for getting undo diffs:
  require("telescope").load_extension("undo")

  -- for browsing git file history:
  require("telescope").load_extension("git_file_history")
EOF

"
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>C <cmd>Telescope commands<cr>
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope git_files<cr>
nnoremap <leader>h <cmd>Telescope git_file_history<cr>
nnoremap <leader>j <cmd>Telescope jumplist<cr>
nnoremap <leader>s <cmd>Telescope spell_suggest<cr>
nnoremap <leader>t <cmd>Telescope builtin<cr>
nnoremap <leader>T <cmd>Telescope telescope-tabs list_tabs<cr>
nnoremap <leader>z <cmd>Telescope current_buffer_fuzzy_find<cr>

nnoremap <leader>d <cmd>Telescope diagnostics<cr>
nnoremap <leader>q <cmd>Telescope quickfix<cr>

" nnoremap <leader>u <cmd>lua require('telescope').extensions.undo.undo()<cr>
nnoremap <leader>u <cmd>Telescope undo<cr>

" only cached pickers:
" nnoremap <leader>p <cmd>Telescope pickers<cr>

" requires ripgrep
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap gr <cmd>Telescope grep_string<cr>

nnoremap gR <cmd>Telescope lsp_references<cr>
