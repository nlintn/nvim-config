local api = vim.api
local cmd = vim.cmd
local utils = require('user.utils')

api.nvim_create_user_command('BgTransparencyToggle', utils.bg_transparency_toggle,
  { desc = 'Toggle background transparency' })
api.nvim_create_user_command('UpdatePwd', utils.update_pwd,
  { desc = 'Update pwd to git root of currently opened file' })

api.nvim_create_user_command('DiffOrig', function()
  cmd [[ vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis ]]
end, { desc = 'Show diff of buffer to saved file' })
