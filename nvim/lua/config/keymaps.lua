vim.keymap.set("n", "<leader>f", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "Format current file" })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')