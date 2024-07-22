-- Set leader to " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NOTE: OPTIONS -----------------------------------------------------------------------------------------------------
vim.opt.number = true -- Add line number
vim.opt.relativenumber = true -- Add relative line numbers
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time. Displays which-key popup sooner
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.g.have_nerd_font = true -- Set true if you have a Nerd Font installed and selected in the terminal
-- Take care of indentation stuff
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.title = true -- When on, the title of the window will be set to the value of 'titlestring'. :set titlestring = "test"
vim.opt.wrap = false -- Code does not wrap around if line is too long
vim.opt.virtualedit = "block" -- When in visual block mode, we can select a block even if not all lines are of equal length
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlight set by vim.opt.hlsearch on pressing <Esc> in normal mode

--NOTE: KEYMAPS -------------------------------------------------------------------------------------------

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier. Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>b", ":Neotree reveal filesystem left toggle<CR>", { desc = "Toggle neotree file system" }) -- Toggle neo tree file system navigation

--NOTE: AUTOCOMMANDS --------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight when yanking (copying) text
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--NOTE: INSTALL LAZY PLUGIN MANAGER ------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--NOTE: CONFIGURE PLUGINS ----------------------------------------------------------------------------------
local plugins = {
	{ -- SOLARIZED-OSAKA COLORSCHEME - By devaslife
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
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"numToStr/Comment.nvim",
	{ -- GITSIGNS - Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{ -- WHICH-KEY - Useful plugin to show pending keybinds. As I type, I'll see the available keybind combinations.
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
	},
	{ -- CONFORM - Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 500 })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					async = false,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
			},
		},
	},
	{ -- NVIM-LINT - Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Disable the default ruby linter
			lint.linters_by_ft["ruby"] = nil

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				json = { "jsonlint" },
				ruby = { "rubocop" },
			}

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "[l]int current file" })
		end,
	},
	{ -- TODO-COMMENTS - Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{ -- NVIM-CMP - Autocompletion
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
	},
	{ -- MINI.NVIM - Collection of 40+ independent lua modules improving overall nvim experience
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
		end,
	},
	{ -- TELESCOPE: Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Simplifies building Neovim plugins by offering functionalities for asynchronous tasks, file operations, and more.
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- Leverages the fzf fuzzy finder for faster and more efficient searching within Telescope's features.
				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make", -- Compiles the plugin from source using the `make` tool.

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Useful for getting pretty icons. REQUIRES A NERD FONT.
			{ -- Enhances the user interface for selections within telescope
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").setup({
						extensions = {
							["ui-select"] = {
								require("telescope.themes").get_dropdown({}),
							},
						},
					})
					require("telescope").load_extension("ui-select")
				end,
			},
		},
		config = function() -- TELESCOPE CONFIGURATION
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin") -- A module provided telescope that contains a collection of built-in pickers (predefined search functionalities) that Telescope offers.

			-- Set Telescope-specific keymaps
			-- Main keymaps
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" }) -- Quickly find and open files in my project directory.
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" }) -- Find all occurrences of the word under the cursor in ny project.
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" }) -- Search for a string across all files in my project.
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" }) -- If I was interrupted or need to revisit a previous search, this keybinding provides a quick way to continue where I left off
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" }) -- Manage and switch between open files.

			-- Keymaps for additional convenience
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" }) -- Easier way to search for :help
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" }) -- Lists all keymaps
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" }) -- Lists Telescope pickers (basically all its functionalities)
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" }) -- Shows errors, warnings, etc
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10, -- Adds a transparency effect to the dropdown window.
					previewer = false, -- Disables the preview window to make the dropdown cleaner.
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true, -- Limits the search to open files.
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>snv", function() -- Directly searches my Neovim config files
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eo[V]im files" })
		end,
	},
	{ -- TREESITTER: Takes snippets of code and generates an abstract syntax tree. This information is then utilized for highlighting, editing and navigating code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"ruby",
				"python",
				"json",
				"css",
			},

			auto_install = true, -- Autoinstall languages that are not installed

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" }, -- Since Ruby may experience issues with TS's indentation rules it can use additional vim regex-based syntax highlighting
			},

			indent = { enable = true, disable = { "ruby" } },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>sl",
					node_incremental = "<leader>si",
					scope_incremental = "<leader>sc",
					node_decremental = "<leader>sd",
				},
			},
		},
		config = function(_, opts) -- TREESITTER CONFIGURATION
			require("nvim-treesitter.install").prefer_git = true -- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.configs").setup(opts) -- Requires nvim-treesitter.configs module and calls the setup function. The setup function takes the opts table as an argument and uses it to configure treesitter
		end,
	},
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
					"tsserver",
					"ruby_lsp",
					"pyright",
					"graphql",
					"eslint",
					"jsonls",
					"html",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.ruby_lsp.setup({})
			lspconfig.pyright.setup({})
			lspconfig.graphql.setup({})
			lspconfig.eslint.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.html.setup({})
			-- Lspconfig-specific keybinds
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- When hovering over an element I can press shift+k to see its documentation
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- Go to definition
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}

local opts = {
	{
		"LazyVim/LazyVim",
		opts = {
			colorScheme = "solarized-osaka",
		},
	},
}

-- We now need to call the setup function for lazy in order to load it
require("lazy").setup(plugins, opts)

-- Modeline: Sets tab stops, soft tab stops, shift width to 2 spaces, and converts tabs to spaces.
-- vim: ts=2 sts=2 sw=2 et
