" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

lua<<EOF
  require'nvim-treesitter.configs'.setup({
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = {
      "css",
      "go",
      "javascript",
      "jq",
      "json",
      "json5",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "ruby",
      "rust",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
      enable = true,
    },

    -- experimental:
    indent = {
      -- don't like the indentation in markdown, so...
      -- enable = true,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        -- init_selection = "gnn",
        -- node_incremental = "grn",
        -- scope_incremental = "grc",
        -- node_decremental = "grm",
        init_selection = "gn",
        node_incremental = "gn",
        scope_incremental = "grc",
        node_decremental = "gm",
      },
    },

  })
EOF
