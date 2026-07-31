---@module 'vim-fugitive'

return {
  'tpope/vim-fugitive',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>gf', '<cmd>G<CR>', desc = 'Git Fugitive' },
    { '<leader>gs', '<cmd>Git status<CR>', desc = 'Git Status' },
    { '<leader>gd', '<cmd>Git diff<CR>', desc = 'Git Diff' },
    { '<leader>gC', '<cmd>Git commit<CR>', desc = 'Git Commit' },
    { '<leader>gP', '<cmd>Git push<CR>', desc = 'Git Push' },
    { '<leader>gp', '<cmd>Git pull<CR>', desc = 'Git Pull' },
    { '<leader>gl', '<cmd>Git log<CR>', desc = 'Git Log' },
    { '<leader>gL', '<cmd>Git log --graph --oneline<CR>', desc = 'Git Log Graph' },
  },
}
