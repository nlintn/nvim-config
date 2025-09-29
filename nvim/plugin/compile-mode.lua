local cmd = vim.cmd
local g = vim.g
local keymap = vim.keymap

g.compile_mode = {
  baleia_setup = true,
}

keymap.set({ 'n' }, '<C-c>', function() cmd('vert bo Compile') end, { desc = 'Compile' })
