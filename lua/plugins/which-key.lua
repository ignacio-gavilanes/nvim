return { -- WHICH-KEY - Useful plugin to show pending keybinds. As I type, I'll see the available keybind combinations.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		local wk = require("which-key")
		wk.setup()

		wk.add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>h", group = "Git [H]unk" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>w", group = "[W]orkspace" },
		})

		-- Register visual mode mappings with the new spec
		wk.add({
			{ "<leader>h", desc = "Git [H]unk", mode = "v" },
		})
	end,
}
