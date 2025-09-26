local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

if fn.empty(fn['provider#clipboard#Executable']()) == 1
    or os.getenv('SSH_TTY') ~= nil then
  g.clipboard = 'osc52'
  g.loaded_clipboard_provider = nil
  cmd.runtime('autoload/provider/clipboard.vim')
end
