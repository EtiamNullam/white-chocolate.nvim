local M = {}

---@nodiscard
local function define_colors()
  local colors = {
    divider = { 'comment', 'floating_window' },
    yank_preview = {
      normal = { 'background', 'foreground' },
      special = { 'background', 'string' },
      special_alternate = { 'background', 'parameter' },
    },
    vi = {
      normal = { 'action', 'background' },
      insert = { 'background', 'info' },
      visual = { 'background', 'string' },
      replace = { 'background', 'change' },
      command = { 'background', 'special' },
    },
    status_line = { 'background', 'foreground' },
    lsp = {
      panel = { 'background', 'action' },
      error = { 'background', 'error' },
      warning = { 'background', 'change' },
      info = { 'background', 'info' },
      hint = { 'foreground', 'floating_window' },
    },
  }

  colors.search = colors.vi.replace
  colors.modified = colors.vi.replace
  colors.readonly = colors.vi.visual

  return colors
end

---@nodiscard
local function build_custom_components(default_components, colors, state)
  local cache_utils = require('windline.cache_utils')
  local custom_components = {}

  custom_components.divider = { default_components.basic.divider, colors.divider }

  custom_components.vi_mode = {
    name = 'vi_mode',
    hl_colors = {
      Normal = colors.vi.normal,
      Insert = colors.vi.insert,
      Visual = colors.vi.visual,
      Replace = colors.vi.replace,
      Command = colors.vi.command,
    },
    text = function()
      return {
        { ' ' .. state.mode[1] .. ' ', state.mode[2] },
      }
    end,
  }

  custom_components.file = {
    name = 'file',
    text = cache_utils.cache_on_buffer(
      {
        'TextChanged',
        'TextChangedI',
        'DirChanged',
        'BufEnter',
        'CmdlineLeave',
        'InsertLeave',
      },
      'wl_file',
      function()
        local file_path = vim.fn.getreg('%')

        if string.len(file_path) == 0 then
          return ''
        end

        local modified = vim.bo.modified
        local readonly = vim.bo.readonly

        local color = modified and colors.modified
          or readonly and colors.readonly
          or colors.status_line

        local modified_marker = modified and ' ● ' or ' '

        return {
          { ' ', color },
          { default_components.basic.cache_file_icon({ default = '' }) },
          { ' ' .. (file_path or '[No Name]') .. modified_marker },
        }
      end
    ),
  }

  custom_components.file_extra = {
    name = 'file_extra',
    text = cache_utils.cache_on_buffer(
      'BufWritePost',
      'wl_file_extra',
      function()
        local path = vim.api.nvim_buf_get_name(0)
        local size = vim.fn.getfsize(path)

        if size > 0 then
          return {
            { ' ', colors.status_line },
            { default_components.basic.cache_file_size({ base = 10, precision = 1 }) },
            { ' ' },
          }
        else
          return ''
        end
      end
    ),
  }

  custom_components.working_directory = {
    name = 'working_directory',
    text = cache_utils.cache_on_buffer(
      'DirChanged',
      'wl_working_directory',
      function()
        local working_directory_path = vim.fn.getcwd()

        local short_working_directory_path = working_directory_path:gsub(
          vim.fn.expand('~'),
          '~'
        )

        return {
          { ' ' .. short_working_directory_path .. ' ', colors.status_line },
        }
      end
    )
  }

  custom_components.lsp = {
    name = 'lsp',
    text = function(bufnr)
      local padded_format = ' %s '

      if default_components.lsp.check_lsp(bufnr) then
        return {
          { ' ', colors.lsp.panel },
          { default_components.lsp.lsp_name { icon = '󰒓 ' } },
          { ' ' },
          { default_components.lsp.lsp_error { format = padded_format }, colors.lsp.error },
          { default_components.lsp.lsp_warning { format = padded_format }, colors.lsp.warning },
          { default_components.lsp.lsp_info { format = padded_format }, colors.lsp.info },
          { default_components.lsp.lsp_hint { format = padded_format }, colors.lsp.hint },
        }
      else
        return ''
      end
    end,
  }

  custom_components.location = {
    text = function()
      return {
        { default_components.basic.line_col_lua, colors.divider },
        { default_components.basic.progress_lua },
        { ' ' },
      }
    end,
  }

  local newline_character = '\n'

  custom_components.yank_preview = {
    name = 'yank_preview',
    text = cache_utils.cache_on_global(
      {
        'TextChanged',
        'CmdlineLeave',
        'TextYankPost',
        'UILeave',
        'FocusGained',
      },
      'wl_yanked_text',
      function()
        local content = vim.fn.getreg('"')

        local function remove_special_characters_excluding_newline(text)
          return text:gsub('[%z\1-\9\11-\31\128-\255]', '')
        end

        local yank_preview_special_color = {}

        do
          local use_alternative_special_character_background = false

          yank_preview_special_color.get_next = function()
            local color = use_alternative_special_character_background
              and colors.yank_preview.special_alternate
              or colors.yank_preview.special

            use_alternative_special_character_background = not use_alternative_special_character_background
            return color
          end

          yank_preview_special_color.reset = function()
            use_alternative_special_character_background = false
          end
        end

        local function split_to_lines(text, char_limit)
          local lines = {}
          local space_left = char_limit

          local line = ''

          for character in text:gmatch('.') do
            if character == newline_character then
              local line_length = line:len()

              space_left = space_left - line_length - 1

              if space_left < 0 then
                break
              end

              if line_length > 0 then
                table.insert(lines, { line, colors.yank_preview.normal })
                yank_preview_special_color.reset()
              end

              table.insert(lines, { ' ↲ ', yank_preview_special_color.get_next() })

              line = ''
            else
              line = line .. character
            end
          end

          local line_length = line:len()

          if line_length > 0 and line_length <= space_left then
            table.insert(lines, { line, colors.yank_preview.normal })
          end

          if #text > char_limit then
            table.insert(lines, { ' ... ', yank_preview_special_color.get_next() })
          end

          return lines
        end

        local stripped_content = remove_special_characters_excluding_newline(content)

        local lines = split_to_lines(stripped_content, 50)

        return lines
      end
    )
  }

  local group = vim.api.nvim_create_augroup(
    'WhiteChocolateWindlineForceRedraw',
    { clear = true }
  )

  vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
      group = group,
      callback = function()
        vim.api.nvim_command(':redrawstatus!')
      end,
    }
  )

  return custom_components
end

---@nodiscard
local function assemble_statusline(default_components, custom_components, colors)
  return {
    filetypes = { 'default' },
    active = {
      custom_components.lsp,
      custom_components.lsp_diag,
      custom_components.git,
      custom_components.yank_preview,
      custom_components.divider,
      { default_components.vim.search_count(), colors.search },
      custom_components.working_directory,
    },
    inactive = {},
  }
end

local function assemble_winbar(default_components, custom_components, colors)
  return {
    filetypes = { 'winbar' },
    active = {
      custom_components.location,
      custom_components.divider,
      custom_components.file_extra,
      custom_components.file,
      custom_components.vi_mode,
    },
    inactive = {
      custom_components.location,
      custom_components.divider,
      custom_components.file,
    }
  }
end

---@param windline WindLine
---@param theme_colors WhiteChocolate.ColorScheme
local function setup(windline, theme_colors)
  vim.o.laststatus = 3

  local state = _G.WindLine.state

  local default_components = {
    basic = require('windline.components.basic'),
    vim = require('windline.components.vim'),
    lsp = require('windline.components.lsp'),
    git = require('windline.components.git'),
  }

  local colors = define_colors()
  local custom_components = build_custom_components(default_components, colors, state)
  local statusline = assemble_statusline(default_components, custom_components, colors)
  local winbar = assemble_winbar(default_components, custom_components, colors)

  windline.setup {
    statuslines = {
      statusline,
      winbar,
    },
    colors_name = function()
      return theme_colors
    end,
  }
end

---@param colors WhiteChocolate.ColorScheme
function M.try_setup(colors)
  local loaded, windline = pcall(require, 'windline')

  if loaded then
    setup(windline, colors)
  else
    local utils = require('white-chocolate.utils')

    local message = utils.assemble_missing_optional_dependency_message('windline (statusline)')

    utils.display_message(message)
  end
end

return M
