local M = {}

M.colorscheme_name = 'white-chocolate'

---@return table<string, string> colorscheme
local function create_colorscheme()
  return {
    base00 = '#fffdfb', -- background
    base01 = '#f2edeb', -- cursorline
    base02 = '#dbd1cf', -- select
    base03 = '#b19892', -- comment
    base04 = '#6f5c80', -- linenumber
    base05 = '#61331f', -- cursor
    base06 = '#b49e2e', -- custom1
    base07 = '#11b7ee', -- custom2
    base08 = '#a8231c', -- red, message, error
    base09 = '#54c878', -- value, search
    base0A = '#d76f22', -- search, type
    base0B = '#81ba01', -- green, string
    base0C = '#a54dff', -- special, telescope fuzzy
    base0D = '#345af1', -- method
    base0E = '#e104a3', -- keyword
    base0F = '#6c87a3', -- slash, punctuation
  }
end

---@generic T : table
---@param target table<string, any>|nil
---@param defaults T
---@return T
local function add_defaults(target, defaults)
  return setmetatable(
    target or {},
    { __index = defaults }
  )
end

---@class WhiteChocolateOptions
  ---@field apply_colorscheme boolean

---@type WhiteChocolateOptions
M.default_options = {
  apply_colorscheme = true,
}

---@param colorscheme_name string
---@return boolean
local function is_colorscheme_already_added(base16, colorscheme_name)
  for _, available_colorscheme in pairs(base16.available_colorschemes()) do
    if available_colorscheme == colorscheme_name then
      return true
    end
  end

  return false
end

---@param base16 table<string, any>
---@param colorscheme table<string, string>
local function add_colorscheme(base16, colorscheme)
  base16.colorschemes[M.colorscheme_name] = colorscheme
end

---@param options WhiteChocolateOptions
local function apply_options(options)
  local base16 = require('base16-colorscheme')

  if not is_colorscheme_already_added(base16, M.colorscheme_name) then
    add_colorscheme(base16, create_colorscheme())
  end

  if options.apply_colorscheme then
    base16.setup(M.colorscheme_name)
  end
end

---@param source table
---@param target_value any
---@return table
local function copy_keys_and_set_values_to(source, target_value)
  local new_table = {}

  for key, _ in pairs(source) do
    new_table[key] = target_value
  end

  return new_table
end

---@param options_or_target_state nil|boolean|WhiteChocolateOptions
function M.setup(options_or_target_state)
  local options = options_or_target_state == nil and M.default_options
    or options_or_target_state == true and copy_keys_and_set_values_to(M.default_options, true)
    or add_defaults(options_or_target_state, M.default_options)

  apply_options(options)
end

return M
