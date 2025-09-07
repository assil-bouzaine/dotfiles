-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "carbonfox",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  telescope = { style = "bordered" },
}

M.cheatsheet = {
  theme = "simple",
}

M.term = {
  float = {
    relative = "editor",
    row = 0.125,
    col = 0.15,
    width = 0.7,
    height = 0.7,
    border = "single",
  },
}
return M
