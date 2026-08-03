---@module 'nvim-dap'
---@module 'nvim-dap-ui'

return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    opts = {
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          disconnect = '⏏',
          pause      = '⏸',
          play       = '▶',
          run_last   = '↺',
          step_back  = '↶',
          step_into  = '↓',
          step_out   = '↑',
          step_over  = '↷',
          terminate  = '□',
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = {
        collapsed     = '▸',
        current_frame = '→',
        expanded      = '▾',
      },
      layouts = {
        {
          elements = {
            { id = 'scopes',      size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks',      size = 0.25 },
            { id = 'watches',     size = 0.25 },
          },
          position = 'right',
          size = 50,
        },
        {
          elements = {
            { id = 'repl',    size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          position = 'bottom',
          size = 10,
        },
      },
      mappings = {
        edit   = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open   = 'o',
        remove = 'd',
        repl   = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    },
    config = function(_, opts)
      local dapui = require('dapui')
      local dap = require('dap')

      dapui.setup(opts)

      for action, operation in pairs({
        attach           = 'open',
        launch           = 'open',
        event_terminated = 'close',
        event_exited     = 'close',
      }) do
        dap.listeners.before[action].dapui_config = function()
          dapui[operation]()
        end
      end
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
    },
    keys = {
      { '<c-p>', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      { '<leader>pc', function() require('dap').clear_breakpoints() end, desc = 'Clear all breakpoints' },
      { '<leader>pl', function() require('dap').list_breakpoints() end, desc = 'List breakpoints' },
      { '<leader><leader>d', function()
        if vim.fn.filereadable('.vscode/launch.json') == 1 then
          require('dap.ext.vscode').load_launchjs()
        end
        require('dap').continue()
      end, desc = 'DAP Continue' },
    },
    config = function(_, opts)
      local dap = require('dap')

      dap.defaults.fallback.exception_breakpoints = { 'uncaught' }

      require('dap-python').setup('python3')

      for name, adapter in pairs(opts.adapters or {}) do
        dap.adapters[name] = adapter
      end

      for ft, configs in pairs(opts.configurations or {}) do
        dap.configurations[ft] = configs
        dap.listeners.on_config[ft] = function(config)
          local c = vim.deepcopy(config)
          if type(c.args) == 'string' then
            c.args = require('dap.utils').splitstr(c.args)
          end
          return c
        end
      end
    end,
  },
}
