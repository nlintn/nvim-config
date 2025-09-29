local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local M = {}

function M.bg_transparency_apply()
  if g.bg_transparency == nil then
    g.bg_transparency = g.default_bg_transparency or false
  end

  if g.bg_transparency then
    cmd.highlight('Normal guibg=nil')
    cmd.highlight('NormalNC guibg=nil')
  else
    cmd.colorscheme(g.colors_name)
  end
end

function M.bg_transparency_apply_colo()
  if g.bg_transparency == nil then
    g.bg_transparency = g.default_bg_transparency or false
  end

  if g.bg_transparency then
    cmd.highlight('Normal guibg=nil')
    cmd.highlight('NormalNC guibg=nil')
  end
end

function M.bg_transparency_toggle()
  g.bg_transparency = not g.bg_transparency
  M.bg_transparency_apply()
end

function M.close_floats()
  for _, win in ipairs(api.nvim_list_wins()) do
    if api.nvim_win_get_config(win).relative ~= ''
        or vim.list_contains({ 'compilation', 'help', 'qf' }, bo[api.nvim_win_get_buf(win)].filetype) then
      api.nvim_win_close(win, false)
    end
  end
end

function M.close_floats_then(f)
  return function()
    M.close_floats()
    f()
  end
end

function M.update_pwd()
  api.nvim_set_current_dir(fn.fnamemodify(fn.finddir('.git', '.;'), ':h'))
end

return M
