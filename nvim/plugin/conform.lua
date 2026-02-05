local api = vim.api
local g = vim.g
local keymap = vim.keymap
local o = vim.o

local conform = require('conform')

conform.setup {
  formatters_by_ft = {
    bash = { 'shfmt' },
    css = { 'prettierd' },
    go = { 'gofmt' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    json = { 'jq' },
    less = { 'prettierd' },
    lua = { 'stylua', lsp_format = "prefer" },
    markdown = { 'prettierd' },
    nix = { 'nixfmt' },
    python = { 'ruff' },
    sh = { 'shfmt' },
    typescript = { 'prettierd' },
    yaml = { 'prettierd' },
    zsh = { 'shfmt' },
    ['*'] = { 'trim_whitespace', 'trim_newlines' },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
}

o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'

g.format_on_save = true
api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function(ev)
    if g.format_on_save == true then
      conform.format({ bufnr = ev.buf })
    end
  end,
})

keymap.set({ 'n' }, 'g<CR>', function() conform.format({ async = true }) end, { desc = 'Format buffer' })
