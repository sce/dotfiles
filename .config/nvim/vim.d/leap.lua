-- https://codeberg.org/andyg/leap.nvim
-- vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
-- vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  require('leap').leap {}
end)
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
  require('leap').leap { backward = true }
end)


vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
vim.api.nvim_set_hl(0, 'LeapMatch', {
  -- For light themes, set to 'black' or similar.
  fg = 'white', bold = true, nocombine = true,
})
