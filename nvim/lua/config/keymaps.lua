vim.keymap.set("n", "<leader>f", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "Format current file" })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- in your keymaps.lua or init.lua
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })



-- in your keymaps.lua or init.lua
vim.keymap.set("n", "<C-q>", function()
  -- Check if Neo-tree window is open
  local neo_tree_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "neo-tree" then
      neo_tree_open = true
      break
    end
  end

  -- Close Neo-tree if open
  if neo_tree_open then
    vim.cmd("Neotree close")
  end

  -- Quit Neovim
  vim.cmd("qa")
end, { desc = "Close Neo-tree (if open) and quit Neovim" })
