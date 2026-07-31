---
--- Configuration for the prettier formatter.
---
return {
  'stevearc/conform.nvim',
  opts = {
    prettier = {
      config = true,
      config_command = '--config',
      config_names = {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.yml',
        '.prettierrc.yaml',
        '.prettierrc.json5',
        '.prettierrc.js',
      },
      config_path = '.prettierrc.json',
    },
  },
}
