return {
	"nvim-lualine/lualine.nvim",
	ependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = "solarized_dark",
			-- disabled_filetypes = { "neo-tree" }, // Disable status line when navigating fs
		},
		extensions = { "neo-tree" }, -- Enhance the look of lualine for when navigating fs
	},
}
