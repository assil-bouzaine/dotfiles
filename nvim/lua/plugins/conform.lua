-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
    })

    -- Keymap: format current buffer
    vim.keymap.set("n", "<leader>f", function()
      conform.format({ async = true, lsp_fallback = true })
    end, { desc = "Format buffer" })
  end,
}
