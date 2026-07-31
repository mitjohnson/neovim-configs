---@module 'nvim-ufo'

-- Find the line bounds of the <template> block by scanning the buffer directly.
-- Avoids depending on the exact treesitter node type, which differs between
-- grammar versions (template_element vs element).
local function get_template_bounds(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local ts, te = nil, nil
  for i, line in ipairs(lines) do
    if not ts and line:match('^<template') then
      ts = i - 1  -- 0-indexed
    elseif ts and line:match('^</template') then
      te = i - 1  -- 0-indexed
      break
    end
  end
  return ts, te
end

-- Custom provider for Vue files:
--   - LSP (Volar) handles JS folds inside <script>
--   - Treesitter handles HTML element folds inside <template>
--   - The whole-script-block treesitter fold is excluded by only including
--     treesitter ranges that fall strictly inside the <template> bounds
local function vue_provider(bufnr)
  local ufo = require('ufo')
  local ts, te = get_template_bounds(bufnr)

  return ufo.getFolds(bufnr, 'lsp'):thenCall(function(lsp_ranges)
    if not ts then
      return lsp_ranges or {}
    end
    -- Vue's treesitter folds.scm only captures top-level SFC blocks, not
    -- inner HTML elements. Use indent-based folding for the template section
    -- instead — HTML indentation maps directly to element nesting.
    return ufo.getFolds(bufnr, 'indent'):thenCall(function(indent_ranges)
      local merged = {}
      for _, r in ipairs(lsp_ranges or {}) do
        table.insert(merged, r)
      end
      for _, r in ipairs(indent_ranges or {}) do
        if r.startLine > ts and r.endLine < te then
          table.insert(merged, r)
        end
      end
      return merged
    end)
  end):catch(function()
    return ufo.getFolds(bufnr, 'indent')
  end)
end

return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost',
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
  },
  opts = {
    provider_selector = function(_, filetype)
      if filetype == 'vue' then
        return vue_provider
      end
      return { 'treesitter', 'indent' }
    end,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local closing = vim.fn.getline(endLnum):match('^%s*(.-)%s*$')
      local suffix = ('  ⋯ %d  %s'):format(endLnum - lnum, closing)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      local newVirtText = {}
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          table.insert(newVirtText, { chunkText, chunk[2] })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end,
  },
}
