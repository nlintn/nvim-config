local api = vim.api
local cmd = vim.cmd
local utils = require('utils')

api.nvim_create_user_command('UpdatePwd', utils.update_pwd, {})
api.nvim_create_user_command('BgTransparencyToggle', utils.bg_transparency_toggle, { desc = 'Toggle background transparency' })
api.nvim_create_user_command('DiffOrig', function ()
  cmd[[ vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis ]]
end, {})
