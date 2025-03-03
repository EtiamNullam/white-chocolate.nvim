local M = {}

---@param cokeline any
---@param theme_colors WhiteChocolate.ColorScheme
local function setup(cokeline, theme_colors)
  local colors = {
    default = theme_colors.foreground,
    focused = theme_colors.background,
    dimmed = theme_colors.floating_window,
    readonly = theme_colors.string,
    modified = theme_colors.change,
  }

  local components = {
    icon = {
      text = function(buffer)
        return ' ' .. buffer.devicon.icon
      end,
    },
    unique_prefix = {
      text = function(buffer)
        return buffer.unique_prefix
      end,
      fg = colors.dimmed,
    },
    filename = {
      text = function(buffer)
        return #buffer.filename > 0
          and buffer.filename .. ' '
          or ''
      end,
    },
    modified_marker = {
      text = function(buffer)
        return buffer.is_modified and '● '
          or ''
      end,
    },
    tab = {
      text = function(tab)
        if tab.is_first and tab.is_last then
          return ''
        end

        return ' ' .. tab.index .. ' '
      end,
      fg = function(tab)
        return tab.is_active and colors.focused
          or colors.default
      end,
      bg = function(tab)
        return not tab.is_active and colors.focused
          or colors.default
      end,
    },
  }

  cokeline.setup {
    default_hl = {
      fg = function(buffer)
        return buffer.is_focused and colors.focused
          or buffer.is_modified and colors.modified
          or buffer.is_readonly and colors.readonly
          or colors.default
      end,
      bg = function(buffer)
        return not buffer.is_focused and colors.focused
          or buffer.is_modified and colors.modified
          or buffer.is_readonly and colors.readonly
          or colors.default
      end
    },
    components = {
      components.icon,
      components.unique_prefix,
      components.filename,
      components.modified_marker,
    },
    tabs = {
      placement = 'right',
      components = {
        components.tab,
      },
    },
  }

  -- set tabline background
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = theme_colors.cursorline })
end

---@param colors WhiteChocolate.ColorScheme
function M.try_setup(colors)
  local loaded, cokeline = pcall(require, 'cokeline')

  if loaded then
    setup(cokeline, colors)
  else
    require('white-chocolate.messenger').display_message('Missing optional dependency: noib3/cokeline.nvim')
  end
end

return M
