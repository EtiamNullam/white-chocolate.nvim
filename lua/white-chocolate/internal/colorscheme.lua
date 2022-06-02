local M = {}

local base16 = require('base16-colorscheme')

M.name = 'white-chocolate'

---@return Base16.Colorscheme colorscheme
local function create()
  return {
    base00 = '#fffdfb', -- background
    base01 = '#f2edeb', -- cursorline
    base02 = '#dbd1cf', -- select
    base03 = '#b19892', -- comment
    base04 = '#6f5c80', -- linenumber
    base05 = '#61331f', -- cursor
    base06 = '#b49e2e', -- custom1
    base07 = '#11b7ee', -- custom2
    base08 = '#a8231c', -- red, message, error
    base09 = '#54c878', -- value, search
    base0A = '#d76f22', -- search, type
    base0B = '#81ba01', -- green, string
    base0C = '#a54dff', -- special, telescope fuzzy
    base0D = '#345af1', -- method
    base0E = '#e104a3', -- keyword
    base0F = '#6c87a3', -- slash, punctuation
  }
end

---@class Base16.Colorscheme
  ---@field base00 string
  ---@field base01 string
  ---@field base02 string
  ---@field base03 string
  ---@field base04 string
  ---@field base05 string
  ---@field base06 string
  ---@field base07 string
  ---@field base08 string
  ---@field base09 string
  ---@field base0A string
  ---@field base0B string
  ---@field base0C string
  ---@field base0D string
  ---@field base0E string
  ---@field base0F string

---@type Base16.Colorscheme?
function M.get_colors()
  return base16.colors
end

---@return boolean
function M.is_already_added()
  for _, available_colorscheme in pairs(base16.available_colorschemes()) do
    if available_colorscheme == M.name then
      return true
    end
  end

  return false
end

function M.add()
  base16.colorschemes[M.name] = create()
end

function M.apply()
  base16.setup(M.name)
end

return M
