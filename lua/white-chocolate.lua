local M = {}

local utils = require('white-chocolate.internal.utils')
local message_maker = require('white-chocolate.internal.message-maker')

---@class WhiteChocolateOptions
  ---@field apply_colorscheme boolean
  ---@field invert_visual boolean
  ---@field tweak_nontext boolean
  ---@field tweak_float boolean

---@type WhiteChocolateOptions
M.default_options = {
  apply_colorscheme = true,
  invert_visual = true,
  tweak_nontext = true,
  tweak_float = true,
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

  local colors = colorscheme.get_colors()
  local is_base16_initialized = colors ~= nil
  local modules_failed_due_to_lack_of_initialization_of_base16 = {}


  if options.tweak_nontext then
    if is_base16_initialized then
      vim.api.nvim_command('highlight NonText ctermfg=7 guifg=' .. colors.base02)
    else
      table.insert(modules_failed_due_to_lack_of_initialization_of_base16, 'tweak_nontext')
    end
  end

  if options.tweak_float then
    if is_base16_initialized then
      vim.api.nvim_command('highlight NormalFloat guibg=' .. colors.base02)
      vim.api.nvim_command('highlight FloatBorder guibg=' .. colors.base02)
    else
      table.insert(modules_failed_due_to_lack_of_initialization_of_base16, 'tweak_float')
    end
  end

  if #modules_failed_due_to_lack_of_initialization_of_base16 ~= 0 then
    local message = message_maker.assemble_colorscheme_not_initialized_message(
      modules_failed_due_to_lack_of_initialization_of_base16
    )

    utils.display_message(message)
  end
end

---@param options_or_load_all_flag? boolean|WhiteChocolateOptions
function M.setup(options_or_load_all_flag)
  local options = options_or_load_all_flag == nil and M.default_options
    or options_or_load_all_flag == true and utils.copy_keys_and_set_values(M.default_options, true)
    or utils.add_defaults(options_or_load_all_flag, M.default_options)

  apply_options(options)
end

return M
