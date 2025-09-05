require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
