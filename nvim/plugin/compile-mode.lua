local g = vim.g
local keymap = vim.keymap

g.compile_mode = {
  default_command = "",
  baleia_setup = true,
  bang_expansion = true,
}

keymap.set({ 'n' }, '<C-k>', '<Cmd>vert bo Compile<CR>', { desc = 'Compile' })
keymap.set({ 'n' }, '<C-K>', '<Cmd>vert bo Recompile<CR>', { desc = 'Recompile' })
