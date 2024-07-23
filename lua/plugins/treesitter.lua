return { -- TREESITTER: Takes snippets of code and generates an abstract syntax tree. This information is then utilized for highlighting, editing and navigating code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"javascript",
			"typescript",
			"ruby",
			"python",
			"json",
			"css",
		},

		auto_install = true, -- Autoinstall languages that are not installed

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" }, -- Since Ruby may experience issues with TS's indentation rules it can use additional vim regex-based syntax highlighting
		},

		indent = { enable = true, disable = { "ruby" } },

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>sl",
				node_incremental = "<leader>si",
				scope_incremental = "<leader>sc",
				node_decremental = "<leader>sd",
			},
		},
	},
	config = function(_, opts) -- TREESITTER CONFIGURATION
		require("nvim-treesitter.install").prefer_git = true -- Prefer git instead of curl in order to improve connectivity in some environments
		require("nvim-treesitter.configs").setup(opts) -- Requires nvim-treesitter.configs module and calls the setup function. The setup function takes the opts table as an argument and uses it to configure treesitter
	end,
}
