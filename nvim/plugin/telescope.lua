local telescope = require('telescope')
telescope.setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
}

local tele_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', tele_builtin.find_files, { desc = 'Telescope: find file' })
vim.keymap.set('n', '<leader>fb', tele_builtin.buffers, { desc = 'Telescope: list buffers' })
vim.keymap.set('n', '<leader>fh', tele_builtin.help_tags, { desc = 'Telescope: list help' })
vim.keymap.set('n', '<leader>lg', tele_builtin.live_grep, { desc = 'Telescope: live grep' })
vim.keymap.set('n', '<leader>gs', tele_builtin.grep_string, { desc = 'Telescope: grep string' })
vim.keymap.set('n', '<leader>ts', tele_builtin.treesitter, { desc = 'Telescope: treesitter' })
vim.keymap.set('n', '<leader>cmd', tele_builtin.commands, { desc = 'Telescope: list commands' })
vim.keymap.set('n', '<leader>ls', tele_builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope: list symbols (dynamic)' })
vim.keymap.set('n', '<leader>ld', tele_builtin.lsp_document_symbols, { desc = 'Telescope: list symbols (static)' })
vim.keymap.set('n', '<leader>lr', tele_builtin.lsp_references, { desc = 'Telescope: list references' })
vim.keymap.set('n', '<leader>li', tele_builtin.lsp_implementations, { desc = 'Telescope: list implementations' })
vim.keymap.set('n', '<leader>ld', tele_builtin.lsp_type_definitions, { desc = 'Telescope: list definitions' })

telescope.load_extension('fzf')

telescope.load_extension('telescope-tabs')
vim.keymap.set('n', '<leader>tt', require('telescope-tabs').list_tabs, { desc = 'Telescope: list tabs' })

telescope.load_extension('ui-select')
