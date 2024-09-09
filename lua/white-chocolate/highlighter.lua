---@class WhiteChocolate.Highlighter
local M = {}

---@alias WhiteChocolate.Highlight [string[], vim.api.keyset.highlight]

---@param colors WhiteChocolate.ColorScheme
---@param options WhiteChocolate.InitOptions
---@return WhiteChocolate.Highlight[]
---@nodiscard
function M.create(colors, options)
  return {
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
      { bg = colors.cursorline }
    },
    {
      { 'CursorLineNr' },
      {
        bg = colors.cursorline,
        fg = colors.foreground,
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
      { bg = colors.cursorline }
    },
    {
      { 'PmenuThumb' },
      { bg = colors.cursor }
    },
    {
      {
        'Comment',
        '@comment',
        'NonText',
        'DiagnosticHint',
        'CmpItemKindText',
      },
      { fg = colors.comment }
    },
    {
      {
        'SignColumn',
        'LineNr',
      },
      { bg = colors.background }
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
      { 'FoldColumn' },
      {
        bg = colors.background,
        fg = colors.comment,
      }
    },
    {
      { 'Todo' },
      { fg = colors.change }
    },
    {
      {
        'DiffAdd',
        'diffAdded',
      },
      { fg = colors.string }
    },
    {
      {
        'DiffChange',
        'diffChanged',
      },
      { fg = colors.change }
    },
    {
      {
        'DiffDelete',
        'diffRemoved',
      },
      { fg = colors.error }
    },
    {
      { 'DiffText' },
      {
        bg = colors.floating_window,
        reverse = true,
      }
    },
    {
      { 'MatchParen' },
      { reverse = true }
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
    {
      { 'LspReferenceText' },
      { underline = true }
    },
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
    {
      {
        'String',
        'CmpItemKindFile',
      },
      { fg = colors.string }
    },
    {
      {
        'Function',
        '@function',
        'CmpItemKindFunction',
        'CmpItemKindMethod',
      },
      { fg = colors.action }
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
      { fg = colors.key }
    },
    {
      {
        'Constant',
        'CmpItemKindConstant',
        'CmpItemKindEnumMember',
        '@lsp.type.enumMember',
      },
      { fg = colors.current }
    },
    {
      {
        '@property',
        '@lsp.type.property',
        '@variable.member',
        'DiagnosticInfo',
        'CmpItemKindProperty',
      },
      { fg = colors.info }
    },
    {
      {
        'Identifier',
        'CmpItemKindVariable',
        '@variable',
        '@field',
        'CmpItemKindField',
      },
      { fg = colors.foreground }
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
      { fg = colors.change }
    },
    {
      {
        'Special',
        'CmpItemAbbrMatch',
        'CmpItemAbbrMatchFuzzy',
        '@decorator',
        '@event',
        '@variable.builtin',
        'CmpItemKindEvent',
        'CmpItemKindConstructor',
      },
      { fg = colors.special }
    },
    {
      {
        '@lsp.type.variable',
      },
      {}
    },
    {
      {
        '@parameter',
        '@lsp.type.parameter',
      },
      { fg = colors.parameter }
    },
    {
      {
        '@punctuation',
      },
      { fg = colors.special }
    },
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
    {
      {
        'IndentBlanklineChar',
        'IndentBlanklineSpaceChar'
      },
      { fg = colors.floating_window }
    },
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
    {
      { 'LeapBackdrop' },
      { fg = colors.comment }
    },
    {
      { 'LeapMatch' },
      { fg = colors.cursor }
    },
    {
      { 'TelescopeMatching' },
      { fg = colors.special }
    },
    {
      { 'ExtraWhitespace' },
      { bg = colors.change }
    },
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
      { 'SpellBad' },
      {
        undercurl = true,
        sp = colors.error,
      }
    },
    {
      { 'SpellCap' },
      {
        undercurl = true,
        sp = colors.action,
      }
    },
    {
      { 'SpellRare' },
      {
        undercurl = true,
        sp = colors.string,
      }
    },
    {
      { 'SpellLocal' },
      {
        undercurl = true,
        sp = colors.special,
      }
    },
  }
end

---@param names string[]
---@param options vim.api.keyset.highlight
function M.apply(names, options)
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

---@param highlights WhiteChocolate.Highlight[]
function M.apply_many(highlights)
  for _, highlight in pairs(highlights) do
    M.apply(
      highlight[1],
      highlight[2]
    )
  end
end

return M
