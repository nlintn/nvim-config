local o = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

o.title = true
o.titlestring = '%t'

o.confirm = true
o.updatetime = 2000

o.number = true
o.relativenumber = true

o.scrolloff = 8
o.sidescrolloff = 8
o.wrap = false

o.nrformats = { 'alpha', 'bin', 'hex' }
o.virtualedit = 'block'

o.inccommand = 'split'
o.incsearch = true
o.ignorecase = true
o.hlsearch = true

o.tabstop = 4
o.shiftwidth = 0
o.expandtab = true

o.list = true
o.listchars = { tab = '«-»', trail = '·', nbsp = '␣', extends = '⟩', precedes = '⟨' }

o.mouse = 'a'
o.mousemoveevent = true
o.mousemodel = 'extend'

o.conceallevel = 2
o.concealcursor = 'nc'

o.termguicolors = true
o.signcolumn = 'yes:1'
o.showmode = false
o.ruler = false
o.winborder = 'single'

o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldtext = 'nvim_treesitter#foldtext()'
o.foldmethod = 'expr'
o.foldenable = false

o.completeopt = { 'menuone', 'preview', 'noselect', 'fuzzy', 'nosort' }

o.undofile = true

if g.neovide ~= nil then
  g.default_bg_transparency = false

  g.neovide_cursor_animation_length = 0.03
  g.neovide_cursor_trail_size = 0
  g.neovide_cursor_animate_in_insert_mode = false
  g.neovide_cursor_animate_command_line = false
  g.neovide_hide_mouse_when_typing = 1
  g.neovide_normal_opacity = 0.7
else
  g.default_bg_transparency = true
end
