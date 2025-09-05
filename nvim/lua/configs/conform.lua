local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },

    -- Web development
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" }, -- JSX
    typescriptreact = { "prettier" }, -- TSX
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    markdown = { "prettier" },

    -- You can also combine ESLint + Prettier if you want lint fixes + formatting:
    -- javascript = { "eslint_d", "prettier" },
    -- typescript = { "eslint_d", "prettier" },
    -- javascriptreact = { "eslint_d", "prettier" },
    -- typescriptreact = { "eslint_d", "prettier" },
  },

  formatters = {
    -- Python
    black = {
      prepend_args = {
        "--fast",
        "--line-length",
        "80",
      },
    },
    isort = {
      prepend_args = {
        "--profile",
        "black",
      },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
