local api = vim.api
local diagnostic = vim.diagnostic
local keymap = vim.keymap
local lsp = vim.lsp

api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function()
    keymap.set({ 'n' }, '<F3>', lsp.buf.rename,
      { desc = 'Rename symbol', buffer = true })
    keymap.set({ 'n' }, '<F4>', lsp.buf.code_action,
      { desc = 'Code action', buffer = true })
    keymap.set({ 'n' }, 'K', function() lsp.buf.hover { border = 'single', } end,
      { desc = 'Lsp hover', buffer = true })
    keymap.set({ 'n' }, 'g<CR>', lsp.buf.format,
      { desc = 'Format buffer', buffer = true })
    keymap.set({ 'n' }, 'gD', lsp.buf.declaration,
      { desc = 'Go to declaration', buffer = true })
    keymap.set({ 'n' }, 'g[', diagnostic.goto_prev,
      { desc = 'Go to previous diagnostic', buffer = true })
    keymap.set({ 'n' }, 'g]', diagnostic.goto_next,
      { desc = 'Go to next diagnostic', buffer = true })
    keymap.set({ 'n' }, 'gd', lsp.buf.definition,
      { desc = 'Go to definition', buffer = true })
    keymap.set({ 'n' }, 'ge', function() diagnostic.open_float { border = 'single', } end,
      { desc = 'View diagnostics', buffer = true })
    keymap.set({ 'n' }, 'gi', lsp.buf.implementation,
      { desc = 'Go to implementation', buffer = true })
    keymap.set({ 'n' }, 'gl', lsp.codelens.run,
      { desc = 'Run codelens', buffer = true })
    keymap.set({ 'n' }, 'gr', lsp.buf.references,
      { desc = 'View references', buffer = true })
    keymap.set({ 'n' }, 'gs', function() lsp.buf.signature_help { border = 'single', } end,
      { desc = 'View signature', buffer = true })
    keymap.set({ 'n' }, 'gt', lsp.buf.type_definition,
      { desc = 'Go to type definition', buffer = true })

    keymap.set({ 'i', 'v' }, '<C-s>', function() lsp.buf.signature_help { border = 'single', } end,
      { desc = 'View signature', buffer = true })

    api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      pattern = '<buffer>',
      callback = function()
        lsp.codelens.refresh { bufnr = 0 }
      end
    })
  end
})

keymap.del({ 'n', 'x' }, 'gra')
keymap.del({ 'n' }, 'grn')
keymap.del({ 'n' }, 'grr')
keymap.del({ 'n' }, 'grt')
keymap.del({ 'n' }, 'gri')

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
  'bashls',
  'clangd',
  'cssls',
  'eslint',
  'gopls',
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
