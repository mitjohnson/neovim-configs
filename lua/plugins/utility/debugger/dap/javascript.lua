local enter_launch_url = function()
  local co = coroutine.running()
  return coroutine.create(function()
    vim.ui.input(
      { prompt = 'Enter URL: ', default = 'http://localhost:' },
      function(url)
        if url == nil or url == '' then
          return
        else
          coroutine.resume(co, url)
        end
      end
    )
  end)
end

local pwa_alias = function(pwa_type)
  return function(cb, config)
    config.type = pwa_type
    local resolved = require('dap').adapters[pwa_type]
    if type(resolved) == 'function' then
      resolved(cb, config)
    else
      cb(resolved)
    end
  end
end

local pwa_adapter = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vim.fn.stdpath('data')
        .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
      '${port}',
    },
  },
}

local js_configs = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file using Node.js (nvim-dap)',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach to process using Node.js (nvim-dap)',
    processId = require('dap.utils').pick_process,
    cwd = '${workspaceFolder}',
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file using Node.js with ts-node/register (nvim-dap)',
    program = '${file}',
    cwd = '${workspaceFolder}',
    runtimeArgs = { '-r', 'ts-node/register' },
  },
  {
    type = 'pwa-chrome',
    request = 'launch',
    name = 'Launch Chrome (nvim-dap)',
    url = enter_launch_url,
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
  {
    type = 'pwa-msedge',
    request = 'launch',
    name = 'Launch Edge (nvim-dap)',
    url = enter_launch_url,
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
}

return {
  'mfussenegger/nvim-dap',
  opts = {
    adapters = {
      ['pwa-node']   = pwa_adapter,
      ['pwa-chrome'] = pwa_adapter,
      ['pwa-msedge'] = pwa_adapter,
      node   = pwa_alias('pwa-node'),
      chrome = pwa_alias('pwa-chrome'),
      msedge = pwa_alias('pwa-msedge'),
    },
    configurations = {
      typescript      = js_configs,
      javascript      = js_configs,
      typescriptreact = js_configs,
      javascriptreact = js_configs,
      vue             = js_configs,
    },
  },
}
