return { -- SOLARIZED-OSAKA COLORSCHEME - By devaslife
	"craftzdog/solarized-osaka.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	lazy = true,
	opts = function()
		return {
			transparent = true,
		}
	end,
	init = function()
		vim.cmd.colorscheme("solarized-osaka")
	end,
}
