return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- ===========================================
		-- 1. TELESCOPE CORE SETUP
		-- ===========================================
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			-- =====================
			-- DEFAULT CONFIGURATION
			-- =====================
			defaults = {
				-- Use FZF-style sorter for better performance
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				path_display = { "truncate" }, -- Truncate long paths
				mappings = {
					i = {
						["<C-u>"] = false, -- Disable clear prompt mapping
						["<C-d>"] = require("telescope.actions").delete_buffer,
					},
				},
			},

			-- =====================
			-- EXTENSION CONFIGURATION
			-- =====================
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						previewer = false,
						layout_config = {
							width = 0.8,
							height = 0.8,
						},
					}),
				},
				fzf = {
					fuzzy = true, -- Enable fuzzy search
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case", -- Maintain smart case
				},
			},
		})

		-- ===========================================
		-- 2. LOAD EXTENSIONS
		-- ===========================================
		-- Safely load available extensions
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		-- ===========================================
		-- 3. KEYMAPS (Leader-based navigation)
		-- ===========================================
		-- All keymaps use <leader>s as the base prefix
		local keymap = vim.keymap.set

		-- [S]earch [H]elp
		keymap("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })

		-- [S]earch [K]eymaps
		keymap("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })

		-- [S]earch [F]iles
		keymap("n", "<leader>sf", function()
			builtin.find_files({ hidden = true }) -- Include hidden files
		end, { desc = "Search files" })

		-- [S]earch Telescope [S]electors
		keymap("n", "<leader>ss", builtin.builtin, { desc = "Search selectors" })

		-- [S]earch [G]rep
		keymap("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })

		-- [S]earch [W]ord under cursor
		keymap("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })

		-- [S]earch [D]iagnostics
		keymap("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })

		-- [S]earch [R]esume last search
		keymap("n", "<leader>sr", builtin.resume, { desc = "Resume search" })

		-- [S]earch recent files (mnemonic: . for recent)
		keymap("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })

		-- [S]earch [B]uffers
		keymap("n", "<leader>sb", builtin.buffers, { desc = "Search buffers" })

		-- [S]earch [N]eovim config files
		keymap("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Search Neovim config" })

		-- [S]earch [R]egisters
		keymap("n", "<leader>sR", builtin.registers, { desc = "Search registers" })
		-- [S]earch in [O]pen files
		keymap("n", "<leader>so", function()
			builtin.live_grep({ grep_open_files = true })
		end, { desc = "Search in open files" })

		-- Fuzzy search in current buffer
		keymap("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Fuzzy search in buffer" })

		-- ===========================================
		-- 4. ADVANCED CUSTOMIZATION
		-- ===========================================
		-- Custom picker for git files (requires fugitive)
		local function project_files()
			local ok = pcall(builtin.git_files, { show_untracked = true })
			if not ok then
				builtin.find_files()
			end
		end

		keymap("n", "<leader>sp", project_files, { desc = "Search project files" })
	end,
}

