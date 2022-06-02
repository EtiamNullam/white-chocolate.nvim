local M = {}

---@param dependency_name string
---@return string
function M.assemble_missing_optional_dependency_message(dependency_name)
  return 'Optional dependency was requested but is missing: "'
    .. dependency_name
    .. '"'
end

---@param dependent_options string
---@return string
function M.assemble_colorscheme_not_initialized_message(dependent_options)
  local dependent_options_merged = '"' .. table.concat(dependent_options, '", "') .. '"'
  local message = 'Options: ' .. dependent_options_merged .. [[ cannot be applied as "nvim-base16" is not initialized.
Use this colorscheme: require('white-chocolate') { apply_colorscheme = true }
or choose colorscheme yourself and run this first: require('base16-colorscheme').setup(<your colorscheme of choice>)
or disable options listed above to hide this message
]]

  return message
end

return M
