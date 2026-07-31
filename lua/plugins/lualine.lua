return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    { 'folke/noice.nvim' },
  },
  opts = function(_, opts)
    -- Lazily initialize so trouble isn't force-loaded at startup.
    local _symbols = nil
    local function get_symbols()
      if not _symbols then
        local ok, trouble = pcall(require, 'trouble')
        if ok then
          _symbols = trouble.statusline({
            mode = 'lsp_document_symbols',
            groups = {},
            title = false,
            filter = { range = true },
            format = '{kind_icon}{symbol.name:Normal}',
            hl_group = 'lualine_c_normal',
          })
        end
      end
      return _symbols
    end

    local macro_recording = {
      get = function()
        local reg = vim.fn.reg_recording()
        return reg ~= '' and ' @' .. reg or ''
      end,
      has = function()
        return vim.fn.reg_recording() ~= ''
      end,
    }

    opts.theme = 'iceberg_dark'

    opts.sections = vim.tbl_deep_extend('force', {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'filetype' },
      lualine_y = { 'lsp_status' },
      lualine_z = { 'location' },
    }, opts.sections or {})

    table.insert(opts.sections.lualine_x, {
      macro_recording.get,
      cond = macro_recording.has,
      color = { fg = '#ff4444', gui = 'bold' },
    })

    table.insert(opts.sections.lualine_c, {
      function() return get_symbols() and get_symbols().get() or '' end,
      cond = function() return get_symbols() ~= nil and get_symbols().has() end,
    })
  end,
}
