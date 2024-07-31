local M = {}

local utils = require('white-chocolate.utils')

---@class WhiteChocolate.InitOptions
  ---@field invert_visual? boolean
  ---@field setup_bufferline? boolean
  ---@field setup_statusline? boolean
  ---@field tweak_hydra? boolean

---@type WhiteChocolate.InitOptions
M.default_options = {
  invert_visual = true,
  tweak_hydra = true,
  setup_bufferline = true,
  setup_statusline = true,
}

local function set_highlight(names, options)
  local first_name = nil

  for _, name in pairs(names) do
    if first_name == nil then
      vim.api.nvim_set_hl(0, name, options)
      first_name = name
    else
      vim.api.nvim_set_hl(0, name, { link = first_name })
    end
  end
end

local function set_highlights(highlights)
  for _, highlight in pairs(highlights) do
    set_highlight(
      highlight[1],
      highlight[2]
    )
  end
end

local function apply_options(options)
  local colors = M.colors

  vim.o.background = 'light'

  set_highlights {
    -- main
      {
        {
          'Normal',
          'CmpItemKind',
        },
        {
          fg = colors.foreground,
          bg = colors.background,
        }
      },
    {
      {
        'Cursor',
        'lCursor',
        'TermCursor',
      },
      {
        fg = colors.special,
        bg = colors.cursor,
      }
    },
    {
      { 'CursorLine' },
      {
        bg = colors.cursorline,
      }
    },
    {
      { 'CursorLineNr' },
      {
        bg = colors.cursorline,
        fg = colors.line_number,
        bold = true,
      }
    },
    {
      { 'Search' },
      {
        fg = colors.background,
        bg = colors.change,
      }
    },
    {
      { 'IncSearch' },
      {
        fg = colors.background,
        bg = colors.current,
      }
    },
    {
      { 'Underlined' },
      {
        underline = true,
        sp = colors.foreground,
      }
    },
    {
      {
        'NormalFloat',
        'FloatBorder',
        'Pmenu',
      },
      {
        bg = colors.floating_window,
      }
    },
    {
      { 'PmenuSel' },
      {
        bg = colors.foreground,
        fg = colors.background,
      }
    },
    {
      { 'PmenuSbar' },
      {
        bg = colors.cursorline,
      }
    },
    {
      {
        'PmenuThumb'
      },
      {
        bg = colors.cursor,
      }
    },
    {
      {
        'Comment',
        '@comment',
        'NonText',
        'DiagnosticHint',
        'CmpItemKindText',
      },
      {
        fg = colors.comment,
      }
    },
    {
      {
        'SignColumn',
        'LineNr',
      },
      {
        bg = colors.background,
      }
    },
    {
      {
        'Folded',
      },
      {
        bg = colors.cursorline,
      }
    },
    {
      {
        'FoldColumn'
      },
      {
        bg = colors.background,
        fg = colors.comment,
      }
    },
      {
        {
          'Todo'
        },
        {
          fg = colors.change
        }
      },
      {
        {
          'DiffAdd',
          'diffAdded',
        },
        {
          fg = colors.string,
        }
      },
      {
        {
          'DiffChange',
          'diffChanged',
        },
        {
          fg = colors.change,
        }
      },
      {
        {
          'DiffDelete',
          'diffRemoved',
        },
        {
          fg = colors.error,
        }
      },
      {
        {
          'DiffText',
        },
        {
          bg = colors.floating_window,
          reverse = true,
        }
      },
      -- diagnostic underlines
        {
          { 'DiagnosticUnderlineHint' },
          {
            sp = colors.floating_window,
            underline = true,
          }
        },
        {
          { 'DiagnosticUnderlineInfo' },
          {
            sp = colors.info,
            underline = true,
          }
        },
        {
          { 'DiagnosticUnderlineWarn' },
          {
            sp = colors.change,
            underline = true,
          }
        },
        {
          { 'DiagnosticUnderlineError' },
          {
            sp = colors.error,
            underline = true,
          }
        },
      -- errors
        {
          {
            'Error',
            'ErrorMsg',
            'NvimInternalError',
            'DiagnosticError',
          },
          {
            fg = colors.error,
          }
        },
    -- data types
      {
        {
          'String',
          'CmpItemKindFile',
        },
        {
          fg = colors.string,
        }
      },
      {
        {
          'Function',
          '@function',
          'CmpItemKindFunction',
          'CmpItemKindMethod',
        },
        {
          fg = colors.action,
        }
      },
      {
        {
          'Keyword',
          'Conditional',
          'Statement',
          'Exception',
          'PreProc',
          'CmpItemKindKeyword',
        },
        {
          fg = colors.key,
        }
      },
      {
        {
          'Constant',
          'CmpItemKindConstant',
          'CmpItemKindEnumMember',
          '@lsp.type.enumMember',
        },
        {
          fg = colors.current,
        }
      },
      {
        {
          '@property',
          '@lsp.type.property',
          'DiagnosticInfo',
          'CmpItemKindProperty',
        },
        {
          fg = colors.info
        }
      },
      {
        {
          'Identifier',
          'CmpItemKindVariable',
          '@variable',
          '@field',
          'CmpItemKindField',
        },
        {
          fg = colors.foreground,
        }
      },
      {
        {
          'Structure',
          'Type',
          'DiagnosticWarn',
          'CmpItemKindClass',
          'CmpItemKindStruct',
          'CmpItemKindEnum',
          '@lsp.type.enum',
          'Operator',
          'CmpItemKindOperator',
          'Directory',
          'CmpItemKindFolder',
          'Title',
        },
        {
          fg = colors.change,
        }
      },
      {
        {
          'Special',
          'CmpItemAbbrMatch',
          'CmpItemAbbrMatchFuzzy',
          '@decorator',
          '@event',
          'CmpItemKindEvent',
          'CmpItemKindConstructor',
        },
        { fg = colors.special }
      },
      {
        {
          '@parameter',
          '@lsp.type.parameter',
        },
        { fg = colors.parameter }
      },
      -- illuminate
        {
          {
            'IlluminatedWordRead',
            'IlluminatedWordText',
            'IlluminatedWordWrite',
          },
          {
            sp = colors.foreground,
            underline = true,
          }
        },
      -- blankline
        {
          {
            'IndentBlanklineChar',
            'IndentBlanklineSpaceChar'
          },
          { fg = colors.floating_window }
        },
      -- leap
        {
          { 'LeapLabelPrimary' },
          {
            fg = colors.background,
            bg = colors.current,
          },
        },
        {
          { 'LeapLabelSecondary' },
          {
            fg = colors.background,
            bg = colors.action,
          },
        },
        {
          { 'LeapLabelSelected' },
          {
            fg = colors.background,
            bg = colors.special,
          },
        },
    -- telescope
      {
        { 'TelescopeMatching' },
        { fg = colors.special }
      },
    -- leap
      {
        { 'LeapBackdrop' },
        { fg = colors.comment }
      },
      {
        { 'LeapMatch' },
        { fg = colors.cursor }
      },
    -- extra whitespace
    {
      { 'ExtraWhitespace' },
      { bg = colors.change }
    },
    {
      { '@lsp.type.comment' },
      {}
    },
    {
      { 'LspInlayHint' },
      {
        fg = colors.comment,
        bg = colors.cursorline,
      },
    },
  }

  if options.invert_visual then
    set_highlight(
      { 'Visual' },
      {
        reverse = true,
      }
    )
  end

  if options.tweak_hydra then
    set_highlights {
      {
        { 'HydraRed' },
        { fg = colors.error }
      },
      {
        { 'HydraBlue' },
        { fg = colors.action }
      },
      {
        { 'HydraAmaranth' },
        { fg = colors.special }
      },
      {
        { 'HydraTeal' },
        { fg = colors.current }
      },
      {
        { 'HydraPink' },
        { fg = colors.key }
      }
    }
  end

  if options.setup_statusline then
    require('white-chocolate.3rd-party.windline').try_setup(M.colors)
  end

  if options.setup_bufferline then
    require('white-chocolate.3rd-party.cokeline').try_setup(M.colors)
  end

  if options.tweak_matchparen then
    set_highlight(
      {
        'MatchParen',
      },
      {
        reverse = true,
        fg = colors.value,
      }
    )
  end
end

M.colors = {
  background = '#fffdfb',
  foreground = '#643d2c',
  cursor = '#000000',
  cursorline = '#eee9e7',
  floating_window = '#e4d7d3',
  comment = '#9d8580',
  line_number = '#6e84ad',
  parameter = '#b1a600',
  info = '#1aa7d6',
  error = '#da1306', -- red
  current = '#69b98b',
  change = '#be621e',
  string = '#81ba01', -- green
  special = '#a54dff',
  action = '#476cff',
  key = '#bf1ca2',
}

---@param options_or_load_all_flag? boolean | WhiteChocolate.InitOptions
function M.setup(options_or_load_all_flag)
  local options = options_or_load_all_flag == nil and M.default_options
    or options_or_load_all_flag == true and utils.copy_keys_and_set_values(M.default_options, true)
    or utils.add_defaults(options_or_load_all_flag, M.default_options)

  apply_options(options)
end

return M
