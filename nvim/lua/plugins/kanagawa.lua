return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			--transparent=true,
		})
		vim.cmd("colorscheme kanagawa-dragon")

		vim.api.nvim_set_hl(0, "LineNr", { fg = "#888888" }) -- normal line numbers
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true, bg = "NONE" }) -- current line
	end,
}
