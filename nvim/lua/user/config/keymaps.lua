local cmd = vim.cmd
local keymap = vim.keymap
local utils = require('user.utils')

keymap.set('n', '<Esc>', utils.close_floats, { desc = 'Close floating windows' })

keymap.set({ 'n', 'i', 'v', }, '<Up>', function() cmd.normal('gk') end, { desc = 'Visual line up' })
keymap.set({ 'n', 'i', 'v', }, '<Down>', function() cmd.normal('gj') end, { desc = 'Visual line down' })

keymap.set({ 'n', 'i', 'v', }, '<C-ö>', cmd.tabprev, { desc = 'Previous tab' })
keymap.set({ 'n', 'i', 'v', }, '<C-ä>', cmd.tabnext, { desc = 'Next tab' })

keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

keymap.set({ 'n', 'v' }, '<leader><Del>', '"+<Del>')
keymap.set({ 'n', 'v' }, '<leader>c', '"+c')
keymap.set({ 'n', 'v' }, '<leader>C', '"+C')
keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
keymap.set({ 'n', 'v' }, '<leader>D', '"+D')
keymap.set({ 'n', 'v' }, '<leader>r', '"+r')
keymap.set({ 'n', 'v' }, '<leader>R', '"+R')
keymap.set({ 'n', 'v' }, '<leader>s', '"+s')
keymap.set({ 'n', 'v' }, '<leader>S', '"+S')
keymap.set({ 'n', 'v' }, '<leader>x', '"+x')
keymap.set({ 'n', 'v' }, '<leader>X', '"+X')
keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')
