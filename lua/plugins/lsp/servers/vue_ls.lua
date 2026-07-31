---
--- Configuration for the vue language server (vue_ls).
--- Provides LSP support for Vue.js files.
---
return {
  'neovim/nvim-lspconfig',
  opts = {
    vue_ls = {
      init_options = {
        typescript = {
          tsdk = require('utils').npm_root() .. '/typescript/lib',
        },
        vue = {
          version = 2,
          hybridMode = true,
        },
      },
      root_dir = function(fname)
        local util = require('lspconfig.util')
        return util.root_pattern('package.json', 'vue.config.js', '.git')(fname)
      end,
    },
  },
}
