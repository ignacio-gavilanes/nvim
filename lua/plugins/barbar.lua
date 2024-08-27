-- TODO: Fix issue where highlights for git information looks off
-- https://github.com/romgrk/barbar.nvim/issues/533

-- TODO: Fix issue for where buffers start all the way to the left end, instead, make it so that they start after Neo-tree

return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		exclude_name = { "" }, -- Not ideal, but I can hide empty buffers this way for now
		icons = {
			buffer_index = "superscript",
			pinned = { button = "", filename = true },
			modified = { button = "●" },
			gitsigns = {
				added = { enabled = true, icon = "+" },
				changed = { enabled = true, icon = "~" },
				deleted = { enabled = true, icon = "-" },
			},
		},
	},
	-- version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
