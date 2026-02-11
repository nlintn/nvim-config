local api = vim.api
local opt_local = vim.opt_local
local utils = require('user.utils')

local gr_cursorline = api.nvim_create_augroup('CursorLine', {
  clear = true
})
api.nvim_create_autocmd({ 'InsertEnter' }, {
  group = gr_cursorline,
  callback = function()
    opt_local.cursorline = true
  end
})
api.nvim_create_autocmd({ 'InsertLeave', 'WinLeave' }, {
  group = gr_cursorline,
  callback = function()
    opt_local.cursorline = false
  end
})

api.nvim_create_autocmd({ 'ColorScheme' }, {
  callback = utils.bg_transparency_apply_colo
})
