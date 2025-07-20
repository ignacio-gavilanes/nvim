-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers and visuals
vim.opt.number = true -- Add line number
vim.opt.relativenumber = true -- Add relative line numbers
vim.opt.cursorline = true -- Show which line your cursor is on

-- Mouse and UI
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.fillchars = { fold = " ", foldsep = " ", foldopen = "", foldclose = "" } -- Improve appearance of folds
vim.opt.title = true -- When on, the title of the window will be set to the value of 'titlestring'. :set titlestring = "test"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.wrap = false -- Code does not wrap around if line is too long
vim.opt.virtualedit = "block" -- When in visual block mode, we can select a block even if not all lines are of equal length

-- Clipboard and search
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.incsearch = true -- Shows matches as you type
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.undofile = true -- Save undo history
vim.o.undolevels = 10000 -- Increase number of undo levels

-- Selection, backspace, and keyword behavior
vim.opt.selection = "exclusive"
vim.opt.backspace = "indent,eol,start"
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")

-- Editing behavior
vim.opt.breakindent = true -- Enable break indent
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.autowrite = true

-- Split window behavior
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true

-- Indentation
vim.opt.autoindent = true -- Take care of indentation stuff
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Font and shell
vim.g.have_nerd_font = true
vim.opt.shell = "zsh"
