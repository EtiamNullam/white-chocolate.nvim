local M = {}

---@param message string
function M.display_message(message)
  vim.notify('[white-chocolate] ' .. message, vim.log.levels.WARN)
end

---@generic T : table
---@param target table<string, any>|nil
---@param defaults T
---@return T
function M.add_defaults(target, defaults)
  return setmetatable(
    target or {},
    { __index = defaults }
  )
end

---@param source table
---@param target_value any
---@return table
function M.copy_keys_and_set_values(source, target_value)
  local new_table = {}

  for key, _ in pairs(source) do
    new_table[key] = target_value
  end

  return new_table
end

return M
