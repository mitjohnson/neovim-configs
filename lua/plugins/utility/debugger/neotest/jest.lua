local utils = require('utils')

return {
  'nvim-neotest/neotest',
  dependencies = { 'nvim-neotest/neotest-jest' },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
    table.insert(opts.adapters, require('neotest-jest')({
      jestCommand = 'npx jest --no-coverage',
      env = { NODE_ENV = 'test' },
      jestConfigFile = function(file)
        local root = utils.find_root(file, { 'jest.config.js' })
        return root and (root .. '/jest.config.js') or 'jest.config.js'
      end,
      cwd = function(file)
        return utils.find_root(file, { 'jest.config.js' }) or vim.fn.getcwd()
      end,
    }))
  end,
}
