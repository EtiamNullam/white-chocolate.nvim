---@class WhiteChocolate.Plugin
local M = {}

---@type WhiteChocolate.InitOptions
M.default_options = {
  invert_visual = true,
  setup_bufferline = true,
  setup_statusline = true,
  fix_terminal_background = false,
  color_overrides = {},
}

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
    require('white-chocolate.3rd-party.windline').try_setup(colors)
  end

  if options.setup_bufferline then
    require('white-chocolate.3rd-party.cokeline').try_setup(colors)
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
  ---@type WhiteChocolate.InitOptions
  options = vim.tbl_extend('keep', options or {}, M.default_options)

  vim.api.nvim_command('do ColorSchemePre')

  apply_options(options)

  vim.api.nvim_command('do ColorScheme')
end

return M
