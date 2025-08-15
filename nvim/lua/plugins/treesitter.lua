return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Install these parsers automatically
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",  -- Essentials
        "javascript", "typescript", "html", "css", -- Web
        "python", "rust", "go", "java",   -- Languages
        "json", "yaml", "markdown"        -- Data/Content
      },
      
      -- Enable these core features
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      
      -- Additional modules
      autotag = { enable = true },        -- Auto-close HTML/JSX tags
      context_commentstring = { enable = true }, -- Better comments
      playground = { enable = true },      -- View syntax tree
    })
  end
}