local o = vim.o
local g = vim.g

local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

g.mapleader = ' '
g.maplocalleader = ' '

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

o.title = true
o.titlestring = '%t'

o.number = true
o.relativenumber = true

o.scrolloff = 8
o.sidescrolloff = 8
o.wrap = false

o.signcolumn = 'yes:1'

o.ignorecase = true
o.hlsearch = true

o.tabstop = 4
o.shiftwidth = 0
o.expandtab = true

o.list = true
o.listchars='tab:«-»,trail:·,nbsp:␣,extends:⟩,precedes:⟨'

o.termguicolors = true

o.mouse = 'a'
o.mousemoveevent = true
o.mousemodel = 'extend'

o.conceallevel = 2
o.concealcursor = 'nc'

o.clipboard = 'unnamedplus'

o.showmode = false
o.ruler = false

o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldtext = 'nvim_treesitter#foldtext()'
o.foldmethod = 'expr'
o.foldenable = false

o.completeopt = 'menuone,preview,noselect,fuzzy,nosort'

if g.neovide == nil then
  g.neovide_cursor_animation_length = 0.05
  g.neovide_cursor_trail_size = 0
  g.neovide_cursor_animate_in_insert_mode = false
  g.neovide_cursor_animate_command_line = false
  g.neovide_hide_mouse_when_typing = 1
else
    api.nvim_set_hl(0, "Normal", { guibg = nil, ctermbg = nil, })
    api.nvim_set_hl(0, "NormalNC", { guibg = nil, ctermbg = nil, })
    api.nvim_set_hl(0, "LineNr", { guibg = nil, ctermbg = nil, })
end

keymap.set({ 'n', 'i', 'v' , 'x', }, '<Up>', function ()
  local pos = fn.getpos(".")
  pos[2] = pos[2] - 1
  fn.setpos(".", pos)
end)
keymap.set({ 'n', 'i', 'v' , 'x', }, '<Down>', function ()
  local pos = fn.getpos(".")
  pos[2] = pos[2] + 1
  fn.setpos(".", pos)
end)
keymap.set({ 'n', 'i', 'v' , 'x', }, '<C-ö>', "<Cmd>tabprevious<CR>")
keymap.set({ 'n', 'i', 'v' , 'x', }, '<C-ä>', "<Cmd>tabprevious<CR>")

local function update_pwd()
  api.nvim_set_current_dir(fn.fnamemodify(fn.finddir(".git", ".;"), ":h"))
end
update_pwd()
api.nvim_create_user_command("UpdatePwd", update_pwd, {})
api.nvim_create_user_command("WDiff", "<Cmd>w !diff % -<CR>", {})

vim.cmd([[
  augroup CursorLine
    au!
    au InsertEnter * setlocal cursorline
    au WinLeave,InsertLeave * setlocal nocursorline
  augroup END
]])

require('config.colorscheme')
require('config.lsp')
