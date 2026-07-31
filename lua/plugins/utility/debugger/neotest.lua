local utils = require('utils')

return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
      'adrigzr/neotest-mocha',
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
    config = function()
      require('neotest').setup({
        floating = {
          border = 'rounded',
          options = {
            winhighlight = 'NormalFloat:Normal,FloatBorder:FloatBorder',
          },
        },
        adapters = {
          require('neotest-jest')({
            jestCommand = 'npx jest --no-coverage',
            env = { NODE_ENV = 'test' },
            jestConfigFile = function(file)
              local root = utils.find_root(file, { 'jest.config.js' })
              return root and (root .. '/jest.config.js') or 'jest.config.js'
            end,
            cwd = function(file)
              return utils.find_root(file, { 'jest.config.js' }) or vim.fn.getcwd()
            end,
          }),
          require('neotest-mocha')({
            command = 'sh',
            command_args = function(context)
              local parts = {
                'npx mocha',
                '--exit',
                '--require should',
                '--timeout 60000',
                '--full-trace',
                '--reporter=json',
              }
              if context.test_name ~= '' then
                table.insert(parts, '--grep=' .. vim.fn.shellescape(context.test_name_pattern))
              end
              table.insert(parts, vim.fn.shellescape(context.path))
              table.insert(parts, '>' .. vim.fn.shellescape(context.results_path))
              return { '-c', table.concat(parts, ' ') }
            end,
            cwd = function(path)
              return utils.find_root(path, { 'package.json' }) or vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
}
