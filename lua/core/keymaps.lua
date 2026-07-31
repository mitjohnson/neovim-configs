return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  ---@module 'which-key
  ---@class wk.Opts
  opts = {
    spec = {
      -- group labels
      { '<leader>g', group = 'Git' },
      { '<leader>go', group = 'Octo' },
      { '<leader>f', group = 'Find' },
      { '<leader>p', group = 'DAP' },
      -- global Key maps
      { '<C-h>', '<C-w><', desc = 'Decrease window width' },
      { '<C-l>', '<C-w>>', desc = 'Increase window width' },
      { '<C-j>', '<C-w>-', desc = 'Decrease window height' },
      { '<C-k>', '<C-w>+', desc = 'Increase window height' },
      { '<leader>tn', ':tabnext<CR>', desc = 'Next tab' },
      { '<leader>tp', ':tabprevious<CR>', desc = 'Previous tab' },
      { '<leader>tl', ':tablast<CR>', desc = 'Last tab' },
      { '<leader>tF', ':tabfirst<CR>', desc = 'First tab' },
      { '<leader>tc', ':tabclose<CR>', desc = 'Close current tab' },
      { '<leader>to', ':tabnew<CR>', desc = 'Open a new tab' },
      { '<leader>rs', ':LspRestart<cr>', desc = 'Reset LSP' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
