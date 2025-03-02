return { -- TELESCOPE: Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Simplifies building Neovim plugins by offering functionalities for asynchronous tasks, file operations, and more.
		{
			"nvim-telescope/telescope-fzf-native.nvim", -- Leverages the fzf fuzzy finder for faster and more efficient searching within Telescope's features.
			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make", -- Compiles the plugin from source using the `make` tool.

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Useful for getting pretty icons. REQUIRES A NERD FONT.
		{ -- Enhances the user interface for selections within telescope
			"nvim-telescope/telescope-ui-select.nvim",
			config = function()
				require("telescope").setup({
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown({}),
						},
					},
				})
				require("telescope").load_extension("ui-select")
			end,
		},
	},
	config = function() -- TELESCOPE CONFIGURATION
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			defaults = {
				file_ignore_patterns = {
					"node_modules/*",
					"package%-lock.json"
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin") -- A module provided telescope that contains a collection of built-in pickers (predefined search functionalities) that Telescope offers.

		-- Set Telescope-specific keymaps
		-- Main keymaps
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" }) -- Quickly find and open files in my project directory.
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" }) -- Find all occurrences of the word under the cursor in my project.
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" }) -- Search for a string across all files in my project.
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" }) -- If I was interrupted or need to revisit a previous search, this keybinding provides a quick way to continue where I left off
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" }) -- Manage and switch between open files.

		-- Keymaps for additional convenience
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" }) -- Easier way to search for :help
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" }) -- Lists all keymaps
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" }) -- Lists Telescope pickers (basically all its functionalities)
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" }) -- Shows errors, warnings, etc
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10, -- Adds a transparency effect to the dropdown window.
				previewer = false, -- Disables the preview window to make the dropdown cleaner.
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true, -- Limits the search to open files.
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })
		vim.keymap.set("n", "<leader>snv", function() -- Directly searches my Neovim config files
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eo[V]im files" })
	end,
}
