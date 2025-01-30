"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source: https://github.com/nvimtools/none-ls.nvim
" Source: https://github.com/nvimtools/none-ls-extras.nvim
"
" See https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
"
" `none-ls` is the community fork of `null-ls`, and to keep compatibility the
" `null-ls` api is retained.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua<<EOF
  -- Needed by prettier.nvim, eslint.nvim, biome.nvim
  local null_ls = require("null-ls")

  null_ls.setup({
      default_timeout = 10000,
      root_dir = require('lspconfig.util').root_pattern('yarn.lock'),
      sources = {
          -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim

          null_ls.builtins.diagnostics.stylelint, -- for css/sass
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.diagnostics.todo_comments,

          null_ls.builtins.formatting.prettier.with({ timeout = 5000, }),
      },
  })
EOF
