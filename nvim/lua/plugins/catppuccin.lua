return {
  "catppuccin/nvim",
  name = "catppuccin",  -- Plugin name for reference
  priority = 1000,     -- Load before other plugins for proper theming
  lazy = false,        -- Load immediately on startup
  config = function()
    require("catppuccin").setup({
      -- ========================
      -- FLAVOR SELECTION
      -- ========================
      flavour = "macchiato",  -- Options: latte, frappe, macchiato, mocha

      -- ========================
      -- TRANSPARENCY SETTINGS
      -- ========================
      transparent_background = true,  -- Main background transparency
      show_end_of_buffer = false,     -- Hide ~ lines at end of buffer (cleaner look)
      term_colors = true,             -- Apply colors to terminal

      -- ========================
      -- STYLE CUSTOMIZATIONS
      -- ========================
      styles = {
        comments = { "italic" },   -- Italic comments
        conditionals = { "bold" },  -- Bold conditionals (if/else)
        loops = { "bold" },         -- Bold loops
        functions = { "bold" },     -- Bold function names
        keywords = { "italic" },    -- Italic keywords
        strings = {},               -- Normal strings
        variables = {},             -- Normal variables
        numbers = {},               -- Normal numbers
        booleans = { "bold" },      -- Bold booleans
        properties = { "italic" },  -- Italic object properties
        types = { "bold" },         -- Bold type definitions
      },

      -- ========================
      -- INTEGRATION SETTINGS
      -- ========================
      integrations = {
        telescope = true,          -- Better Telescope styling
        neotree = true,            -- Neo-tree integration
        which_key = true,          -- Which-key integration
        indent_blankline = {       -- Indent guides
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {             -- LSP diagnostics
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    })

    -- ========================
    -- APPLY THE COLORSCHEME
    -- ========================
    vim.cmd.colorscheme("catppuccin")
    
    -- ========================
    -- ADDITIONAL TRANSPARENCY
    -- ========================
    -- For floating windows, popups, etc.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })

    -- Make relative numbers more distinct
    vim.api.nvim_set_hl(0, "LineNrAbove", {
      fg = "#ffffff",  -- Catppuccin white
      italic = true
    })
    
    vim.api.nvim_set_hl(0, "LineNrBelow", {
      fg = "#ffffff",  -- Catppuccin white
      italic = true
    })
    
    -- Make current line number stand out
    vim.api.nvim_set_hl(0, "CursorLineNr", {
      fg = "#c6a0f6",  -- Catppuccin mauve
      bold = true,
    })


  end

}