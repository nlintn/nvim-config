local keymap = vim.keymap
local utils = require('utils')

local telescope = require('telescope')
telescope.setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
}

local tele_builtin = require('telescope.builtin')

keymap.set('n', '<leader>ff', utils.close_floats_then(tele_builtin.find_files),
  { desc = 'Telescope: find file' })
keymap.set('n', '<leader>fb', utils.close_floats_then(tele_builtin.buffers),
  { desc = 'Telescope: list buffers' })
keymap.set('n', '<leader>fh', utils.close_floats_then(tele_builtin.help_tags),
  { desc = 'Telescope: list help' })
keymap.set('n', '<leader>lg', utils.close_floats_then(tele_builtin.live_grep),
  { desc = 'Telescope: live grep' })
keymap.set('n', '<leader>gs', utils.close_floats_then(tele_builtin.grep_string),
  { desc = 'Telescope: grep string' })
keymap.set('n', '<leader>ts', utils.close_floats_then(tele_builtin.treesitter),
  { desc = 'Telescope: treesitter' })
keymap.set('n', '<leader>ls', utils.close_floats_then(tele_builtin.lsp_dynamic_workspace_symbols),
  { desc = 'Telescope: list symbols (dynamic)' })
keymap.set('n', '<leader>ld', utils.close_floats_then(tele_builtin.lsp_document_symbols),
  { desc = 'Telescope: list symbols (static)' })
keymap.set('n', '<leader>lr', utils.close_floats_then(tele_builtin.lsp_references),
  { desc = 'Telescope: list references' })
keymap.set('n', '<leader>li', utils.close_floats_then(tele_builtin.lsp_implementations),
  { desc = 'Telescope: list implementations' })
keymap.set('n', '<leader>ld', utils.close_floats_then(tele_builtin.lsp_type_definitions),
  { desc = 'Telescope: list definitions' })

telescope.load_extension('fzf')

telescope.load_extension('telescope-tabs')
local tele_tabs = require('telescope-tabs')
keymap.set('n', '<leader>tt', utils.close_floats_then(tele_tabs.list_tabs), { desc = 'Telescope: list tabs' })

telescope.load_extension('ui-select')
