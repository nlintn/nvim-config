local keymap = vim.keymap

keymap.set({ 'n', 'i', 'v' , }, '<Up>', '<Cmd>normal gk<CR>')
keymap.set({ 'n', 'i', 'v' , }, '<Down>', '<Cmd>normal gj<CR>')

keymap.set({ 'n', 'i', 'v' , 'x', }, '<C-ö>', '<Cmd>tabprevious<CR>')
keymap.set({ 'n', 'i', 'v' , 'x', }, '<C-ä>', '<Cmd>tabprevious<CR>')
