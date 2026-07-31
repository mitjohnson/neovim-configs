---
--- Utility module for Neovim configuration.
--- Provides helper functions for managing configuration files and checking for local configurations.
---
local M = {}

---@type string
---@brief The location of global configuration files.
-- The location of global configuration files.
M.configs_location = vim.fn.stdpath('config') .. '/configs/'

local _npm_root = nil

---@return string
function M.npm_root()
  if not _npm_root then
    _npm_root = vim.fn.trim(vim.fn.system('npm root -g'))
  end
  return _npm_root
end

---@param location string The directory path to start searching from.
---@param config_names string[] A list of configuration file names to search for.
---@returns boolean
function M.has_local_config(location, config_names)
  for _, name in ipairs(config_names) do
    local found = vim.fs.find(name, { upward = true, path = location })
    if #found > 0 then
      return true
    end
  end
  return false
end

return M
