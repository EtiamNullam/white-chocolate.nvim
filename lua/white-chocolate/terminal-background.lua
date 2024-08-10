local M = {}

function M.fix()
  local background = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg

  io.write(string.format('\027Ptmux;\027\027]11;#%06x\007\027\\', background))
  io.write(string.format('\027]11;#%06x\027\\', background))
end

function M.revert()
  io.write('\027Ptmux;\027\027]111;\007\027\\')
  io.write('\027]111\027\\')
end

return M
