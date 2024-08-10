local M = {}

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
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = theme_colors.background })
end

function M.try_setup(colors)
  local loaded, cokeline = pcall(require, 'cokeline')

  if loaded then
    setup(cokeline, colors)
  else
    local message = require('white-chocolate.utils').assemble_missing_optional_dependency_message('cokeline (bufferline)')

    require('white-chocolate.utils').display_message(message)
  end
end

return M
