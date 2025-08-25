return {
  "echasnovski/mini.statusline",
  version = false,
  opts = {
    use_icons = true, -- enable nerd font icons
    set_vim_settings = true, -- recommended
  },
  config = function(_, opts)
    local statusline = require("mini.statusline")
    statusline.setup(opts)

    -- Custom section for Git branch (requires 'vim.b.gitsigns_head')
    local function git_branch()
      return vim.b.gitsigns_head and (" " .. vim.b.gitsigns_head) or ""
    end

    -- Custom section for LSP diagnostics
    local function diagnostics()
      local diags = vim.diagnostic.count(0) or {}
      local symbols = { " ", " ", " ", " " } -- error, warn, info, hint
      local result = {}
      for i, sym in ipairs(symbols) do
        local count = diags[i - 1] or 0
        if count > 0 then
          table.insert(result, sym .. count)
        end
      end
      return table.concat(result, " ")
    end

    -- Override section content
    statusline.section_location = function()
      return "%l:%c │ %p%%"
    end

    statusline.section_filename = function()
      local fname = vim.fn.expand("%:t")
      if fname == "" then fname = "[No Name]" end
      if vim.bo.modified then
        fname = fname .. " "
      end
      return fname
    end

    statusline.section_git = git_branch
    statusline.section_diagnostics = diagnostics

    -- Final composition: mode | git | filename | diagnostics | location
    statusline.section_active = {
      -- Left
      function() return statusline.section_mode() end,
      function() return git_branch() end,
      function() return statusline.section_filename() end,

      -- Right
      function() return diagnostics() end,
      function() return statusline.section_location() end,
    }

    -- Custom override for neo-tree
    local default_active = statusline.active
    statusline.active = function()
      if vim.bo.filetype == "neo-tree" then
        return "%#Normal#  NEO TREE  "
      end
      return default_active()
    end
  end,
}
