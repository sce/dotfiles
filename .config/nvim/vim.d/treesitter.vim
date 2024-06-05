" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

lua<<EOF
  require'nvim-treesitter.configs'.setup({
    highlight = {
      enable = true
    }
  })
EOF
