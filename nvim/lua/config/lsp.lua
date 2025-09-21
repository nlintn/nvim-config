local diagnostic = vim.diagnostic
local keymap = vim.keymap
local lsp = vim.lsp

keymap.set('n', '<F3>', lsp.buf.rename, { desc = 'Rename symbol' })
keymap.set('n', '<F4>', lsp.buf.code_action, { desc = 'Code action' })
keymap.set('n', 'K', function() lsp.buf.hover { border = 'single', } end, { desc = 'Lsp hover' })
keymap.set('n', 'g<CR>', lsp.buf.format, { desc = 'Format buffer' })
keymap.set('n', 'gD', lsp.buf.declaration, { desc = 'Go to declaration' })
keymap.set('n', 'g[', diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
keymap.set('n', 'g]', diagnostic.goto_next, { desc = 'Go to next diagnostic' })
keymap.set('n', 'gd', lsp.buf.definition, { desc = 'Go to definition' })
keymap.set('n', 'ge', function() diagnostic.open_float { border = 'single', } end, { desc = 'View diagnostics' })
keymap.set('n', 'gi', lsp.buf.implementation, { desc = 'Go to implementation' })
keymap.set('n', 'gl', lsp.codelens.run, { desc = 'Run codelens' })
keymap.set('n', 'gr', lsp.buf.references, { desc = 'View references' })
keymap.set('n', 'gs', function() lsp.buf.signature_help { border = 'single', } end, { desc = 'View signature' })
keymap.set('n', 'gt', lsp.buf.type_definition, { desc = 'Go to type definition' })

keymap.set('i', '<C-s>', function() lsp.buf.signature_help { border = 'single', } end, { desc = 'View signature' })
keymap.set('v', '<C-s>', function() lsp.buf.signature_help { border = 'single', } end, { desc = 'View signature' })

keymap.del('n', 'gra')
keymap.del('n', 'grn')
keymap.del('n', 'grr')
keymap.del('n', 'grt')
keymap.del('n', 'gri')

vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
  pattern = '<buffer>',
  callback = function()
    lsp.codelens.refresh { bufnr = 0 }
  end
})

diagnostic.config {
  virtual_text = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    source = 'if_many',
  },
}

lsp.inlay_hint.enable()

lsp.enable {
  'basedpyright',
  'clangd',
  'cssls',
  'eslint',
  'html',
  'isabelle',
  'jsonls',
  'lua_ls',
  'nixd',
  'ocamllsp',
  'rust_analyzer',
  'texlab',
  'ts_ls',
}
