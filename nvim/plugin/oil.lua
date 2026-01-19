local oil = require('oil')

local permission_hlgroups = {
  ['-'] = 'NonText',
  ['r'] = 'DiagnosticSignWarn',
  ['w'] = 'DiagnosticSignError',
  ['x'] = 'DiagnosticSignOk',
  ['s'] = 'Keyword',
  ['t'] = 'Keyword',
  ['T'] = 'Keyword',
}

oil.setup {
  default_file_explorer = true,
  columns = {
    {
      'type',
      icons = {
        ['directory'] = 'd',
        ['file']      = '.',
        ['link']      = 'l',
      },
      highlight = function (type)
        if type == 'd' then
          return 'Directory'
        elseif type == 'l' then
          return 'Special'
        else
          return 'Normal'
        end
      end
    },
    {
      'permissions',
      highlight = function(permission_str)
        local hls = {}
        for i = 1, #permission_str do
          local char = permission_str:sub(i, i)
          table.insert(hls, { permission_hlgroups[char], i - 1, i })
        end
        return hls
      end,
    },
    {
      'size',
      highlight = 'Special',
    },
    {
      'mtime',
      highlight = 'Delimiter',
    },
    {
      'icon',
      add_padding = true,
    },
  },
  cleanup_delay_ms = 10000,
  constrain_cursor = 'name',
  delete_to_trash = true,
  keymaps = {
    ['<C-CR>'] = { 'actions.select', opts = { tab = true } },
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return vim.startswith(name, '..')
    end,
  },
  watch_for_changes = true,
  float = {
    padding = 2,
    border = 'single',
  }
}
vim.keymap.set('n', '-', oil.open_float, { desc = 'Oil: open parent directory' })
