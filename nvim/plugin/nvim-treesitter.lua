require('nvim-treesitter.configs').setup {
  ensure_installed = {},
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = false },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = { query = '@function.outer', desc = 'Select outer part of a function' },
        ['if'] = { query = '@function.inner', desc = 'Select inner part of a function' },
        ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap parameter with next' },
      },
      swap_previous = {
        ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap parameter with previous' },
      },
    },
  }
}
