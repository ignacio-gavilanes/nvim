return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"ruby_lsp",
					"pyright",
					"graphql",
					"eslint",
					"jsonls",
					"html",
					"cssls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the ⁠ vim ⁠ global
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.ts_ls.setup({})
			lspconfig.ruby_lsp.setup({})
			lspconfig.pyright.setup({})
			lspconfig.graphql.setup({})
			lspconfig.eslint.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.html.setup({})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			-- Lspconfig-specific keybinds
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})    -- When hovering over an element I can press shift+k to see its documentation
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- Go to definition
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
