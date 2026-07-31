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
      { '<leader>tN', function() require('neotest').run.run() end, desc = 'Run nearest test' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run file tests' },
      { '<leader>ta', function() require('neotest').run.run({ suite = true }) end, desc = 'Run all tests (suite)' },
      { '<leader>tL', function() require('neotest').run.run_last() end, desc = 'Run last test' },
      { '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end, desc = 'Toggle watch mode' },
      { '<leader>tv', function() require('neotest').output.open({ enter = true, last_run = true }) end, desc = 'Show test output' },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel (raw)' },
      { '<leader>tS', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
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
              local found = vim.fs.find('jest.config.js', { upward = true, path = vim.fn.fnamemodify(file, ':h') })
              if #found > 0 then
                return found[1]
              end
              return 'jest.config.js'
            end,
            cwd = function(file)
              local found = vim.fs.find('jest.config.js', { upward = true, path = vim.fn.fnamemodify(file, ':h') })
              if #found > 0 then
                return vim.fn.fnamemodify(found[1], ':h')
              end
              return vim.fn.getcwd()
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
              local found = vim.fs.find('package.json', { upward = true, path = vim.fn.fnamemodify(path, ':h') })
              if #found > 0 then
                return vim.fn.fnamemodify(found[1], ':h')
              end
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
}
