local api = vim.api
local fn = vim.fn

function Update_pwd()
  api.nvim_set_current_dir(fn.fnamemodify(fn.finddir('.git', '.;'), ':h'))
end

Update_pwd()

require('config')
