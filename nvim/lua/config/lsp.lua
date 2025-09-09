local lsp = vim.lsp
local diagnostic = vim.diagnostic

vim.keymap.set('n', 'K', function() lsp.buf.hover { border = 'single', } end, {})
vim.keymap.set('n', 'gd', lsp.buf.definition, {})
vim.keymap.set('n', 'gl', function() diagnostic.open_float { border = 'single', } end, {})
vim.keymap.set('n', '<F4>', lsp.buf.code_action, {})

vim.keymap.set("n", "]g", diagnostic.goto_next)
vim.keymap.set("n", "[g", diagnostic.goto_prev)

vim.keymap.set('i', '<C-s>', function() lsp.buf.signature_help { border = 'single', } end, {})
vim.keymap.set('v', '<C-s>', function() lsp.buf.signature_help { border = 'single', } end, {})

diagnostic.config {
  virtual_text = true,
}

lsp.enable {
  'clangd',
  'cssls',
  'eslint',
  'html',
  'isabelle',
  'jsonls',
  'lua_ls',
  'nixd',
  'ocamllsp',
  'ruff',
  'rust_analyzer',
  'texlab',
  'ts_ls',
}
