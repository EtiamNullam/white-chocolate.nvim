local M = {}

---@param message string
function M.display_message(message)
  vim.notify('[white-chocolate] ' .. message, vim.log.levels.WARN)
end

return M
