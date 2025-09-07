require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- esc to exit insert mode
vim.api.nvim_set_keymap(
  "t", -- 't' for terminal mode
  "<Esc>", -- key to press
  "<C-\\><C-n>", -- what it does (switch to normal mode)
  { noremap = true, silent = true }
)

-- jj to exit insert mode
vim.api.nvim_set_keymap(
  "t", -- insert mode
  "jj", -- keys to press
  "<C-\\><C-n>", -- what it does (switch to normal mode)
  { noremap = true, silent = true }
)
