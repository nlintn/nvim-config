local keymap = vim.keymap
local treesitter = vim.treesitter

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if treesitter.get_parser(ev.buf, nil, { error = false }) == nil then
      return
    end
    treesitter.start(ev.buf)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
    vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
  end,
})

require('treesitter-context').setup {
  max_lines = 2,
  separator = '─',
}

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
    include_surrounding_whitespace = true,
  },
}

local tsto_select = require('nvim-treesitter-textobjects.select')
local tsto_swap = require('nvim-treesitter-textobjects.swap')

keymap.set({ 'x', 'o' }, 'af', function() tsto_select.select_textobject('@function.outer', 'textobjects') end,
  { desc = 'Select outer part of a function' })
keymap.set({ 'x', 'o' }, 'if', function() tsto_select.select_textobject('@function.inner', 'textobjects') end,
  { desc = 'Select inner part of a function' })
keymap.set({ 'x', 'o' }, 'ac', function() tsto_select.select_textobject('@class.outer', 'textobjects') end,
  { desc = 'Select outer part of a class' })
keymap.set({ 'x', 'o' }, 'ic', function() tsto_select.select_textobject('@class.inner', 'textobjects') end,
  { desc = 'Select inner part of a class' })
keymap.set('n', '<leader>a', function() tsto_swap.swap_next('@parameter.inner') end,
  { desc = 'Swap parameter with next' })
keymap.set('n', '<leader>A', function() tsto_swap.swap_previous('@parameter.outer') end,
  { desc = 'Swap parameter with previous' })
