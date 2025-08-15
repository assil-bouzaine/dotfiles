require('options.settings')


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Format the current buffer
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format file' })

-- Toggle auto-format on save
vim.keymap.set('n', '<leader>uf', function()
  local conform = require('conform')
  conform.format_on_save({
    timeout_ms = 500,
    lsp_fallback = true,
  })
  print('Auto-format on save toggled!')
end, { desc = 'Toggle auto-format' })


-- [[ Lazy.nvim Setup ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize Lazy with empty plugin list
require("lazy").setup(
  {
    require 'plugins.catppuccin',
    require 'plugins.neo-tree',
    require 'plugins.treesitter',
    require 'plugins.telescope',
    require 'plugins.harpoon',
    require 'plugins.lualine',
    require 'plugins.which-key',
    require 'plugins.autopairs',
    require 'plugins.lsp',
    require 'plugins.indent_line',
    require 'plugins.completion',
    require 'plugins.format',
    require 'plugins.hardtime',
    require 'plugins.presence',






  },




  {
    ui = {
      icons = vim.g.have_nerd_font and {} or {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
