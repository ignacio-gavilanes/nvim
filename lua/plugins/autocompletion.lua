return { -- NVIM-CMP - Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- Activates when entering insert mode
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{ -- FRIENDLY-SNIPPETS - Contains premade snippets for various languages/freameworks
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		-- Adds other completion capabilities.
		-- nvim-cmp does not ship with all sources by default. They are split into multiple repos for maintenance purposes
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- Tells nvim-cmp to use luasnip for expanding snippets
				end,
			},

			completion = { completeopt = "menu,menuone,noinsert" }, -- Configures the completion options for the popup menu

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			-- Key maps for completion actions
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(), -- Select the [n]ext item
				["<C-p>"] = cmp.mapping.select_prev_item(), -- Select the [p]revious item

				-- Scroll the documentation window
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- [b]ack
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- [f]orward

				-- Accept the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- [y]es

				["<C-l>"] = cmp.mapping(
					function() -- <c-l> will move you to the right of each of the expansion locations.
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end,
					{ "i", "s" }
				),
				["<C-h>"] = cmp.mapping(function() -- <c-h> is similar, except moving you backwards.
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}
