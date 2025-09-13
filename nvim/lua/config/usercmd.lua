local api = vim.api
local cmd = vim.cmd

api.nvim_create_user_command('UpdatePwd', Update_pwd, {})
api.nvim_create_user_command('DiffOrig', function ()
  cmd[[ vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis ]]
end, {})
