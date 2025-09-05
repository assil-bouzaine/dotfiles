local options = {
  ensure_installed = {
    -- Core
    "bash",
    "fish",
    "lua",
    "luadoc",
    "markdown",
    "python",
    "printf",
    "toml",
    "vim",
    "vimdoc",
    "yaml",

    -- Web development
    "javascript",
    "typescript",
    "tsx", -- React / TSX
    "jsdoc",
    "html",
    "css",
    "scss",
    "json",
    "regex",
    "graphql",
    "dockerfile",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
