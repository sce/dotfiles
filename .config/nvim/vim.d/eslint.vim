"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source: https://github.com/MunifTanjim/eslint.nvim
"
"   Plug 'neovim/nvim-lspconfig'
"   Plug 'jose-elias-alvarez/null-ls.nvim'
"   Plug 'MunifTanjim/eslint.nvim'
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua<<EOF
  local eslint = require("eslint")

  eslint.setup({
    bin = 'eslint', -- or `eslint_d`
    code_actions = {
      enable = true,
      apply_on_save = {
        enable = true,
        types = { "directive", "problem", "suggestion", "layout" },
      },
      disable_rule_comment = {
        enable = true,
        location = "separate_line", -- or `same_line`
      },
    },
    diagnostics = {
      enable = true,
      report_unused_disable_directives = false,
      run_on = "type", -- or `save`
    },
  })

  local lint = require('lint')
  lint.linters_by_ft = {
    javascript = {'eslint',},
    typescript = {'eslint',},
    -- "javascript.jsx" = {'eslint',},
    -- "typescript.tsx" = {'eslint',},
  }
EOF

au BufWritePost * lua require('lint').try_lint()
