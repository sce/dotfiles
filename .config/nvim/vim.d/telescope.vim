"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope:
" Plug 'nvim-lua/plenary.nvim'
" Plug 'BurntSushi/ripgrep'
" Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command GitRoot :lua =string.match(vim.api.nvim_exec2( '!git rev-parse --show-toplevel', {output=true}).output, '\n(%S+)')

lua<<EOF
  require('telescope').setup{
    defaults = {
      path_display = {
        -- hidden,
        -- tail,
        -- absolute,
        -- smart,
        -- filename_first,
        shorten = 10,
        truncate = 1,
      },
      layout_config = {
        horizontal = {
          height = 0.95,
          width = 0.95,
          preview_width = 60,
        },
      },
      mappings = {
        -- n = {
        --   ["<esc>"] = require('telescope.actions').close,
        -- },
        i = {
          -- hit escape to exit telescope:
          -- ["<esc>"] = require('telescope.actions').close,
        },
      }
    },
    pickers = {
      find_files = {
        -- turn off .gitignore:
        no_ignore = true,
        no_ignore_parent = true,
        -- show hidden files:
        hidden = true,
      },
      git_files = {
        -- show_untracked = true,
      },
      lsp_references = {
        include_declaration = false,
        include_current_line = false,
        show_line = false,
      },
    },

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

  -- keymaps:
  local builtin = require("telescope.builtin")
  local utils = require("telescope.utils")

  -- lowercase letter is relative to current buffer or cwd, uppercase letter
  -- is relative to root:
  vim.keymap.set('n', '<leader>f', function() builtin.find_files({ cwd = utils.buffer_dir() }) end, {})
  vim.keymap.set('n', '<leader>g', function() builtin.git_files({ use_git_root = false }) end, {})
  vim.keymap.set('n', '<leader>R', function() builtin.live_grep({ cwd = vim.api.nvim_exec2(':GitRoot', {output=true}).output }) end, {})
EOF

"" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>C <cmd>Telescope commands<cr>
nnoremap <leader>F <cmd>Telescope find_files<cr>
nnoremap <leader>G <cmd>Telescope git_files<cr>
nnoremap <leader>h <cmd>Telescope git_file_history<cr>
nnoremap <leader>j <cmd>Telescope jumplist<cr>
nnoremap <leader>s <cmd>Telescope git_status<cr>
nnoremap <leader>S <cmd>Telescope spell_suggest<cr>
nnoremap <leader>t <cmd>Telescope builtin<cr>
nnoremap <leader>T <cmd>Telescope telescope-tabs list_tabs<cr>
nnoremap <leader>y <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>Y <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>z <cmd>Telescope current_buffer_fuzzy_find<cr>

nnoremap <leader>D <cmd>Telescope diagnostics<cr>
nnoremap <leader>q <cmd>Telescope quickfix<cr>

" nnoremap <leader>u <cmd>lua require('telescope').extensions.undo.undo()<cr>
nnoremap <leader>u <cmd>Telescope undo<cr>

" only cached pickers:
" nnoremap <leader>p <cmd>Telescope pickers<cr>

" requires ripgrep
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap gr <cmd>Telescope grep_string<cr>

nnoremap gR <cmd>Telescope lsp_references<cr>
