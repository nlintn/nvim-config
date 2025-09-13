if vim.g.base16_palette == nil then
  vim.api.nvim_error_writeln('g:base16_palette not set!')
end

vim.cmd.highlight('clear')
vim.g.colors_name = 'base16-palette'

require('base16-colorscheme').setup(vim.g.base16_palette)
