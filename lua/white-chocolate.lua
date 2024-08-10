local M = {}


---@class WhiteChocolate.InitOptions
  ---@field invert_visual? boolean
  ---@field setup_bufferline? boolean
  ---@field setup_statusline? boolean

---@type WhiteChocolate.InitOptions
M.default_options = {
  invert_visual = true,
  setup_bufferline = true,
  setup_statusline = true,
}

---@param names string[]
---@param options vim.api.keyset.highlight
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

---@param highlights table<number, [string[], vim.api.keyset.highlight]>
local function set_highlights(highlights)
  for _, highlight in pairs(highlights) do
    set_highlight(
      highlight[1],
      highlight[2]
    )
  end
end

---@param options WhiteChocolate.InitOptions
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
          'WarningMsg',
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
    -- hydra
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
      },
    {
      {
        'MatchParen',
      },
      {
        reverse = true,
        fg = colors.value,
      }
    },
    {
      { 'Visual' },
      options.invert_visual
        and { reverse = true }
        or {
          fg = colors.background,
          bg = colors.info,
        }
    },
  }

  if options.setup_statusline then
    require('white-chocolate.3rd-party.windline').try_setup(M.colors)
  end

  if options.setup_bufferline then
    require('white-chocolate.3rd-party.cokeline').try_setup(M.colors)
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
  error = '#da1306',
  current = '#69b98b',
  change = '#be621e',
  string = '#81ba01',
  special = '#a54dff',
  action = '#476cff',
  key = '#bf1ca2',
}

---@param options? WhiteChocolate.InitOptions
function M.setup(options)
  options = vim.tbl_extend('keep', options or {}, M.default_options)

  vim.api.nvim_command('do ColorSchemePre')

  apply_options(options)

  vim.api.nvim_command('do ColorScheme')
end

return M
