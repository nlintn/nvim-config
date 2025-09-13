local api = vim.api
local o_local = vim.opt_local

local gr_cursorline = api.nvim_create_augroup('CursorLine', {
  clear = true
})
api.nvim_create_autocmd({ 'InsertEnter' }, {
  group = gr_cursorline,
  callback = function ()
    o_local.cursorline = true
  end
})
api.nvim_create_autocmd({ 'InsertLeave', 'WinLeave' }, {
  group = gr_cursorline,
  callback = function ()
    o_local.cursorline = false
  end
})
