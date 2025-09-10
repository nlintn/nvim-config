require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '│' },
    topdelete    = { text = '┤' },
    changedelete = { text = '┼' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '┃' },
    topdelete    = { text = '┫' },
    changedelete = { text = '╋' },
    untracked    = { text = '┇' },
  },
  current_line_blame = true,
}
