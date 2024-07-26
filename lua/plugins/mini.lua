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
		require("mini.hipatterns").setup() -- Highlight patterns in text
	end,
}
