local cmd = vim.cmd
local keymap = vim.keymap
local utils = require('utils')

keymap.set('n', '<Esc>', utils.close_floats, { desc = 'Close floating windows' })

keymap.set({ 'n', 'i', 'v', }, '<Up>', function() cmd.normal('gk') end, { desc = 'Visual line up' })
keymap.set({ 'n', 'i', 'v', }, '<Down>', function() cmd.normal('gj') end, { desc = 'Visual line down' })

keymap.set({ 'n', 'i', 'v', 'x', }, '<C-ö>', cmd.tabprevious, { desc = 'Previous tab' })
keymap.set({ 'n', 'i', 'v', 'x', }, '<C-ä>', cmd.tabnext, { desc = 'Next tab' })
