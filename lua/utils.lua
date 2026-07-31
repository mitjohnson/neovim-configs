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

local _config_cache = {}

---@param location string
---@param config_names string[]
---@return boolean
function M.has_local_config(location, config_names)
  local dir = vim.fn.fnamemodify(location, ':h')
  local key = dir .. '\0' .. table.concat(config_names, '\0')
  if _config_cache[key] ~= nil then
    return _config_cache[key]
  end
  for _, name in ipairs(config_names) do
    local found = vim.fs.find(name, { upward = true, path = dir })
    if #found > 0 then
      _config_cache[key] = true
      return true
    end
  end
  _config_cache[key] = false
  return false
end

local _root_cache = {}

---@param path string
---@param patterns string[]
---@return string|nil
function M.find_root(path, patterns)
  local dir = vim.fn.fnamemodify(path, ':h')
  local key = dir .. '\0' .. table.concat(patterns, '\0')
  if _root_cache[key] ~= nil then
    return _root_cache[key] or nil
  end
  for _, pattern in ipairs(patterns) do
    local found = vim.fs.find(pattern, { upward = true, path = dir })
    if #found > 0 then
      _root_cache[key] = vim.fn.fnamemodify(found[1], ':h')
      return _root_cache[key]
    end
  end
  _root_cache[key] = false
  return nil
end

local _notified = {}

---@param msg string
---@param level integer
---@param opts? table
function M.notify_once(msg, level, opts)
  if not _notified[msg] then
    _notified[msg] = true
    vim.notify(msg, level, opts)
  end
end

return M
