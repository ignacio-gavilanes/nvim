return { -- solarized-osaka colorscheme by devaslife
	"craftzdog/solarized-osaka.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	lazy = false,
	opts = function()
		return {
			transparent = true,
		}
	end,
	init = function()
		vim.cmd.colorscheme("solarized-osaka")
	end,
}
