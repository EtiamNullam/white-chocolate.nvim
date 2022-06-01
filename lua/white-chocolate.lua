local M = {}

local utils = require('white-chocolate.internal.utils')

---@class WhiteChocolateOptions
  ---@field apply_colorscheme boolean
  ---@field invert_visual boolean

---@type WhiteChocolateOptions
M.default_options = {
  apply_colorscheme = true,
  invert_visual = true,
}


---@param options WhiteChocolateOptions
local function apply_options(options)
  local colorscheme = require('white-chocolate.internal.colorscheme')

  if not colorscheme.is_already_added() then
    colorscheme.add()
  end

  if options.apply_colorscheme then
    colorscheme.apply()
  end

  if options.invert_visual then
    vim.api.nvim_command('highlight Visual gui=inverse')
  end



end

---@param options_or_load_all_flag? boolean|WhiteChocolateOptions
function M.setup(options_or_load_all_flag)
  local options = options_or_load_all_flag == nil and M.default_options
    or options_or_load_all_flag == true and utils.copy_keys_and_set_values_to(M.default_options, true)
    or utils.add_defaults(options_or_load_all_flag, M.default_options)

  apply_options(options)
end

return M
