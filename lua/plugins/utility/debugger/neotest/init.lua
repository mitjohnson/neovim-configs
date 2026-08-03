return {
  'nvim-neotest/neotest',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>TN', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<leader>Tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run file tests' },
    { '<leader>Ta', function() require('neotest').run.run({ suite = true }) end, desc = 'Run all tests (suite)' },
    { '<leader>TL', function() require('neotest').run.run_last() end, desc = 'Run last test' },
    { '<leader>Tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end, desc = 'Toggle watch mode' },
    { '<leader>Tv', function() require('neotest').output.open({ enter = true, last_run = true }) end, desc = 'Show test output' },
    { '<leader>TO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel (raw)' },
    { '<leader>TS', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
  },
  opts = {
    floating = {
      border = 'rounded',
      options = {
        winhighlight = 'NormalFloat:Normal,FloatBorder:FloatBorder',
      },
    },
  },
}
