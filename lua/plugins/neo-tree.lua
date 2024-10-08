return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		-- TODO: Implement a hide functionality for when opening a single
		-- TODO: Hide numbers and ~ for neotree (they go away after changing focus one time)
		vim.keymap.set( -- Toggle neo tree file system navigation
			"n",
			"<leader>b",
			":Neotree reveal filesystem left toggle<CR>",
			{ desc = "Toggle neotree file system" }
		)
	end,
}
