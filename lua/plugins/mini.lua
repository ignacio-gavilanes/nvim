return { -- MINI.NVIM - Collection of 40+ independent lua modules improving overall nvim experience
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 }) -- Better Around/Inside textobjects
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote

		require("mini.surround").setup() -- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- Examples:
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		local hipatterns = require("mini.hipatterns") -- Special words highlighting
		hipatterns.setup({ -- Highlight patterns in text
			highlighters = {
				-- Highlight the following keywords: 'FIXME', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),

				hsl_color = { -- Show hsl colors same as we do for hexa (taken from /craftzdog)
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						local hex_color = utils.hslToHex(h, s, l)

						return hipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		})

		local animate = require("mini.animate") -- Animate common NeoVim actions
		animate.setup({
			scroll = {
				enable = false,
			},
			open = {
				enable = false,
			},
			close = {
				enable = false,
			},
		})

		local indentscope = require("mini.indentscope") -- Animate common NeoVim actions
		indentscope.setup({
			symbol = "│",
			options = { try_as_border = true },
		})
	end,
}
