"
" Install:
" git clone https://github.com/github/copilot.vim ~/.config/nvim/pack/github/start/copilot.vim
"
"
" call plug#begin()
"   Plug 'nvim-lua/plenary.nvim'
"   Plug 'CopilotC-Nvim/CopilotChat.nvim'
" call plug#end()

lua << EOF
  -- -- For copilot.vim
  -- vim.g.copilot_no_tab_map = true
  -- -- Use shift+tab instead to accept copilot suggestions
  -- vim.keymap.set('i',
  --   '<S-Tab>', 'copilot#Accept("\\<S-Tab>")',
  --   { expr = true, replace_keycodes = false }
  -- )

  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })

  require("copilot_cmp").setup()

  require("CopilotChat").setup({
    model = 'gpt-5.2',         -- AI model to use
    temperature = 0.1,         -- Lower = focused, higher = creative
    trusted_tools = nil,       -- Require approval for all tool calls
    window = {
      layout = 'vertical',     -- 'vertical', 'horizontal', 'float'
      width = 0.5,             -- 50% of screen width
    },
    auto_insert_mode = false,   -- Enter insert mode when opening
    mappings = {
      reset = false,
    }
  })

  -- Quick chat keybinding
  vim.keymap.set('n', '<leader>ccq', function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      require("CopilotChat").ask(input, {
        selection = require("CopilotChat.select").buffer
      })
    end
  end, { desc = "CopilotChat - Quick chat" })
EOF
