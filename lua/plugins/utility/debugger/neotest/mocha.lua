local utils = require('utils')

return {
  'nvim-neotest/neotest',
  dependencies = { 'adrigzr/neotest-mocha' },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
    table.insert(opts.adapters, require('neotest-mocha')({
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
    }))
  end,
}
