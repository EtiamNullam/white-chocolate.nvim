---@class WhiteChocolate.Plugin
local M = {}

---@class WhiteChocolate.InitOptions
  ---@field invert_visual? boolean
  ---@field setup_bufferline? boolean
  ---@field setup_statusline? boolean
  ---@field fix_terminal_background? boolean
  ---@field use_previous_options? boolean
  ---@field apply_immediately? boolean
  ---@field trigger_events? boolean
  ---@field color_overrides? WhiteChocolate.ColorScheme.Overrides

---@type WhiteChocolate.InitOptions
M.default_options = {
  invert_visual = true,
  setup_bufferline = false,
  setup_statusline = false,
  fix_terminal_background = false,
  use_previous_options = false,
  apply_immediately = true,
  trigger_events = true,
  color_overrides = {},
}

---@type WhiteChocolate.InitOptions
local last_configuration = M.default_options

---@param options WhiteChocolate.InitOptions
local function apply_options(options)
  local colorscheme = require('white-chocolate.colorscheme')

  local colors = type(options.color_overrides) == 'table'
    and vim.tbl_extend('force', colorscheme, options.color_overrides)
    or colorscheme

  vim.o.background = 'light'

  local highlighter = require('white-chocolate.highlighter')

  local highlights = highlighter.create(colors, options)

  highlighter.apply_many(highlights)

  if options.setup_statusline then
    require('white-chocolate.integrations.windline').try_setup(colors)
  end

  if options.setup_bufferline then
    require('white-chocolate.integrations.cokeline').try_setup(colors)
  end

  -- source: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance
  if options.fix_terminal_background then
    local group = vim.api.nvim_create_augroup('WhiteChocolateFixTerminalBackground', {
      clear = true,
    })

    vim.api.nvim_create_autocmd({
      'UIEnter',
      'ColorScheme',
    }, {
      group = group,
      callback = function()
        require('white-chocolate.terminal-background-fix').apply()
      end,
    })

    vim.api.nvim_create_autocmd('UILeave', {
      group = group,
      callback = function()
        require('white-chocolate.terminal-background-fix').revert()
      end,
    })
  end
end

---@param options? WhiteChocolate.InitOptions
function M.setup(options)
  options = options or {}

  local base_options = options.use_previous_options
    and last_configuration
    or M.default_options

  ---@type WhiteChocolate.InitOptions
  options = vim.tbl_extend('keep', options, base_options)

  if options.apply_immediately then
    if options.trigger_events then
      vim.api.nvim_command('do ColorSchemePre')
    end

    apply_options(options)

    if options.trigger_events then
      vim.api.nvim_command('do ColorScheme')
    end
  end

  last_configuration = options
end

return M
