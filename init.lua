-- Install Lazy plugin manager
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

-- Require options.lua file
-- WARNING: Options need to be loaded before Lazy since I am setting the leader keymap in that file
require("options")

-- Require keypmaps.lua file
require("keymaps")

-- Require autocommands.lua file
require("autocommands")

-- We now need to call the setup function for lazy in order to load it
require("lazy").setup("plugins")

-- Modeline: Sets tab stops, soft tab stops, shift width to 2 spaces, and converts tabs to spaces.
-- Lvim: ts=2 sts=2 sw=2 et
