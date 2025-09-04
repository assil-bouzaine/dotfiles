-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.expandtab = true

-- General Options
vim.o.number = true -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.mouse = "a" -- Mouse support
vim.o.showmode = false -- Hide mode indicator
vim.o.breakindent = true -- Indent wrapped lines
vim.o.undofile = true -- Persistent undo
vim.o.ignorecase = true -- Case-insensitive search
vim.o.smartcase = true -- Smart case sensitivity
vim.o.signcolumn = "no" -- Always show sign column
vim.o.updatetime = 10 -- Shorter update interval
vim.o.timeoutlen = 300 -- Key sequence timeout
vim.o.splitright = true -- Vertical splits right
vim.o.splitbelow = true -- Horizontal splits below
--vim.o.list = true -- Show invisible chars
vim.o.inccommand = "split" -- Live command preview
vim.o.cursorline = true -- Highlight current line
vim.o.scrolloff = 5 -- Minimum screen lines around cursor
vim.o.confirm = true -- Confirm unsaved changes

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
