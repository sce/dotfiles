" Plug 'marko-cerovac/material.nvim'

lua <<EOF
    require("material").setup({
        disable = {
            background = true,
            -- term_colors = true,
        },

        custom_highlights = {
            TabLineSel = { bg = "darkorange", fg = "black" },
            -- title is the number next to tabs
            Title = { bg = "none", fg = "white" },
        }
    });

    -- vim.g.material_style = "lighter";
    -- vim.g.material_style = "deep ocean";
    -- vim.g.material_style = "oceanic";
    -- vim.g.material_style = "palenight";
    vim.g.material_style = "darker";
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" activate colorscheme after all plugins are loaded, to make sure it works:
" autocmd vimenter * colorscheme material
" autocmd vimenter * ++nested colorscheme material
colorscheme material
