---
--- Confiuration for the TypeScript Language Server (ts_ls) with Vue support.
--- Provides LSP support for TypeScript, JavaScript, and Vue files.
---
return {
  'neovim/nvim-lspconfig',
  opts = {
    ts_ls = {
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = require('utils').npm_root() .. '/@vue/typescript-plugin',
            languages = { 'javascript', 'typescript', 'vue' },
          },
        },
      },
      filetypes = { 'javascript', 'typescript', 'vue' },
    },
  },
}
