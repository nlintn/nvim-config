local utils = require('utils')

vim.keymap.set('n', '<leader>gg', utils.close_floats_then(vim.cmd.LazyGit), { desc = 'Open LazyGit' })
