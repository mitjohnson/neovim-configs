---@module 'diffview'

return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gD', '<cmd>DiffviewOpen<CR>', desc = 'Git Diff View' },
    { '<leader>gF', '<cmd>DiffviewFileHistory %<CR>', desc = 'Git File History' },
    { '<leader>gx', '<cmd>DiffviewClose<CR>', desc = 'Git Close Diff' },
  },
}
