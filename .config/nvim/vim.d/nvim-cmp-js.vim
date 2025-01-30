" This file requires "runtime vim.d/nvim-cmp.vim"
"
" $ yarn global add typescript typescript-language-server
" $ export PATH=$PATH:~/.yarn/bin

lua <<EOF
  -- commands = {
  --   "_typescript.applyCodeAction",
  --   "_typescript.applyRefactoring",
  --   "_typescript.applyRenameFile",
  --   "_typescript.applyWorkspaceEdit",
  --   "_typescript.configurePlugin",
  --   "_typescript.goToSourceDefinition"
  --   "_typescript.organizeImports",
  -- }

  -- codeActionKinds = {
  --   "quickfix",
  --   "refactor"
  --   "source.addMissingImports.ts",
  --   "source.fixAll.ts",
  --   "source.organizeImports.ts",
  --   "source.removeUnused.ts",
  --   "source.removeUnusedImports.ts",
  --   "source.sortImports.ts",
  -- }

  -- From https://www.reddit.com/r/neovim/comments/lwz8l7/how_to_use_tsservers_organize_imports_with_nvim/
  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = "",
    }
    vim.lsp.buf.execute_command(params)
  end

  -- From https://github.com/neovim/neovim/issues/20784#issuecomment-1288085253
  local function rename_file()
    local source_file, target_file

    -- vim.ui.input({
    --     prompt = "Source : ",
    --     completion = "file",
    --     default = vim.api.nvim_buf_get_name(0)
    -- },
    --     function(input)
    --         source_file = input
    --     end
    -- )

    source_file = vim.api.nvim_buf_get_name(0)

    vim.ui.input({
        prompt = "Target : ",
        completion = "file",
        default = source_file
    },
        function(input)
            target_file = input
        end
    )

    local params = {
        command = "_typescript.applyRenameFile",
        arguments = {
            {
                sourceUri = source_file,
                targetUri = target_file,
            },
        },
        title = ""
    }

    vim.lsp.util.rename(source_file, target_file)
    vim.lsp.buf.execute_command(params)
  end


  -- Set up lspconfig and autocomplete:
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require('lspconfig')['ts_ls'].setup {
    capabilities = capabilities,
    root_dir = require('lspconfig.util').root_pattern('yarn.lock'),

    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      },
      RenameFile = {
          rename_file,
          description = "Rename File"
      },
    }
  }
EOF
