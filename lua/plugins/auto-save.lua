return {
	"okuuva/auto-save.nvim", -- Forked from pocco81/auto-save.nvim (has not being maintained for a while now)
	cmd = "ASToggle",
	event = { "InsertLeave", "TextChanged" },
	opts = {
		execution_message = {
			enabled = false, -- disable the auto-save message
		},
	},
}
