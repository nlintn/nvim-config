local g = vim.g
local keymap = vim.keymap

g.compile_mode = {
  baleia_setup = true,
  bang_expansion = true,
}

keymap.set({ 'n' }, '<C-k>','<Cmd>vert bo Compile<CR>', { desc = 'Compile' })
