return { -- Generates an AST. This info is then utilized for highlighting, editing and navigating code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- Whenever TS is installed/updated we run :TSUpdate which updates all installed parsers
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
      "scss",
			"tsx",
      "regex",
		},

		auto_install = true, -- Autoinstall languages that are not installed
		highlight = {
			enable = true, -- To make use of the AST generated instead of relying on regex (default nvim behavior)
			additional_vim_regex_highlighting = { "ruby" },  -- Since Ruby may experience issues with TS's indentation rules it can use additional vim regex-based syntax highlighting
		},

		indent = { enable = true, disable = { "ruby" } }, -- Enables correct indentation with =
		incremental_selection = { -- Place cursor in expression and navigate the syntax tree with <leader>i to increment and backspace to decrement
			enable = true,
			keymaps = {
				init_selection = "<leader>i",
				node_incremental = "<leader>i",
        scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},

	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true -- Prefer git instead of curl in order to improve connectivity in some environments
		require("nvim-treesitter.configs").setup(opts) -- Requires nvim-treesitter.configs module and calls the setup function. The setup function takes the opts table as an argument and uses it to configure treesitter
	end,
}

