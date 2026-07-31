---@module 'oil'

return {
  'stevearc/oil.nvim',
  lazy = true,
  keys = {
    { '-', function() require('oil').open() end, desc = 'Open Oil' },
  },
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
