---@module 'octo'

return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    enable_builtin = true,
    notifications = {
      current_repo_only = false,
    },
  },
  keys = {
    { '<leader>gol', '<cmd>Octo pr list<CR>', desc = 'PR List' },
    { '<leader>goc', '<cmd>Octo pr checkout<CR>', desc = 'PR Checkout' },
    { '<leader>gor', '<cmd>Octo review start<CR>', desc = 'Review Start' },
    { '<leader>gos', '<cmd>Octo review submit<CR>', desc = 'Review Submit' },
    { '<leader>goi', '<cmd>Octo issue list<CR>', desc = 'Issue List' },
    { '<leader>goI', '<cmd>Octo search is:issue is:open assignee:@me<CR>', desc = 'My Issues' },
    { '<leader>gon', '<cmd>Octo notification list<CR>', desc = 'Notifications' },
  },
}
