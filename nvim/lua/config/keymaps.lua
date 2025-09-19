local api = vim.api
local cmd = vim.cmd
local keymap = vim.keymap

keymap.set('n', '<Esc>', function ()
  for _, win in ipairs(api.nvim_list_wins()) do
    if api.nvim_win_get_config(win).relative ~= '' then
      api.nvim_win_close(win, false)
    end
  end
end, { desc = 'Close floating windows' })

keymap.set({ 'n', 'i', 'v', }, '<Up>', function () cmd.normal('gk') end, { desc = 'Visual line up' })
keymap.set({ 'n', 'i', 'v', }, '<Down>', function () cmd.normal('gj') end, { desc = 'Visual line down' })

keymap.set({ 'n', 'i', 'v', 'x', }, '<C-ö>', cmd.tabprevious, { desc = 'Previous tab' })
keymap.set({ 'n', 'i', 'v', 'x', }, '<C-ä>', cmd.tabnext, { desc = 'Next tab' })
