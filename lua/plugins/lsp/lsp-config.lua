---@module 'nvim-lspconfig'
---@module 'mason.nvim'

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'antosha417/nvim-lsp-file-operations', config = true },
    {
      'williamboman/mason.nvim',
      opts = {
        ensure_installed = {
          'html',
          'emmet_language_server',
          'cssls',
          'bashls',
          'pylsp',
          'vimls',
          'lua_ls',
          'eslint',
          'ts_ls',
          'vue_ls',
        },
        version = {
          ['vue-language-server'] = 'v2.2.8',
        },
      },
    },
  },
  import = 'plugins.lsp.servers',
  config = function(_, opts)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for server, settings in pairs(opts) do
      settings.capabilities = capabilities
      vim.lsp.config(server, settings or {})
      vim.lsp.enable(server)
    end

    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = true,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
    })

  end,
}
