---
--- Configuration for the Lua Language Server (lua_ls).
--- Provides LSP support for Lua files, including Neovim's Lua API.
---
return {
  'neovim/nvim-lspconfig',
  opts = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    },
  },
}

