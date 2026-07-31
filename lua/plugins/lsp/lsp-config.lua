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

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local buf = event.buf
        local map = function(keys, cmd, desc)
          vim.keymap.set('n', keys, cmd, { buffer = buf, desc = desc })
        end
        map('K', '<cmd>lua require("noice.lsp").hover()<cr>', 'LSP: Hover')
        map('gd', '<cmd>Telescope lsp_definitions<cr>', 'LSP: Go to Definition')
        map('<leader>gt', '<cmd>Telescope lsp_type_definitions<cr>', 'LSP: Type Definitions')
        map('<leader>rn', vim.lsp.buf.rename, 'LSP: Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Action')
        map('<leader>D', '<cmd>Telescope diagnostics bufnr=0<cr>', 'LSP: Buffer Diagnostics')
      end,
    })

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
