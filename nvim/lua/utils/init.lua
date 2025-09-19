local api = vim.api
local fn = vim.fn

local M = {}

function M.update_pwd()
  api.nvim_set_current_dir(fn.fnamemodify(fn.finddir('.git', '.;'), ':h'))
end

return M
