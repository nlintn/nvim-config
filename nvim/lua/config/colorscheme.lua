if vim.g.base16_palette ~= nil then
  vim.cmd.colorscheme('base16-palette')
else
  vim.cmd.colorscheme('base16-catppuccin-macchiato')
end
