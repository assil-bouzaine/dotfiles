-- Set space as global leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Flag for Nerd Font availability
vim.g.have_nerd_font = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- General Options
vim.o.number = true           -- Line numbers
vim.o.relativenumber = true   -- Relative line numbers
vim.o.mouse = 'a'             -- Mouse support
vim.o.showmode = false        -- Hide mode indicator
vim.o.breakindent = true      -- Indent wrapped lines
vim.o.undofile = true         -- Persistent undo
vim.o.ignorecase = true       -- Case-insensitive search
vim.o.smartcase = true        -- Smart case sensitivity
vim.o.signcolumn = 'yes'      -- Always show sign column
vim.o.updatetime = 10       -- Shorter update interval
vim.o.timeoutlen = 300        -- Key sequence timeout
vim.o.splitright = true       -- Vertical splits right
vim.o.splitbelow = true       -- Horizontal splits below
vim.o.list = true             -- Show invisible chars
vim.o.inccommand = 'split'    -- Live command preview
vim.o.cursorline = true       -- Highlight current line
vim.o.scrolloff = 10          -- Minimum screen lines around cursor
vim.o.confirm = true          -- Confirm unsaved changes


vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- Clipboard integration (delayed setup)
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Invisible characters configuration
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Diagnostic configuration
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}
