local base16 = require('base16-colorscheme')

if vim.g.base16_colors ~= nil then
  base16.setup(vim.g.base16_colors)
else
  base16.setup("catppuccin-macchiato")
end
