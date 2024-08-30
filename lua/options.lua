-- Set leader to " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.opt.fillchars = { fold = " ", foldsep = " ", foldopen = "", foldclose = "" } -- Improve appearance of folds
-- NOTE: This option may or may not help me remove the numbers that appear in the gutter when folding
-- https://stackoverflow.com/questions/74397698/how-to-remove-the-fold-level-numbers-in-vim
vim.opt.foldcolumn = "0"
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
vim.o.undolevels = 10000 -- Increase number of undo levels
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlight set by vim.opt.hlsearch on pressing <Esc> in normal mode

vim.opt.shell = "zsh"

-- Customize warnings, errors, hints and info.
vim.diagnostic.config({
	signs = {
		text = { -- To disable them I can set them all to ""
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})
