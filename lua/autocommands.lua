vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight when yanking text
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", { -- Open NeoTree when Neovim loads
	desc = "Open NeoTree on startup",
	group = vim.api.nvim_create_augroup("kickstart-neotree", { clear = true }),
	command = ":Neotree reveal filesystem left toggle",
})
