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

-- Center cursor position when moving up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keybind to dismiss Noice notifications
vim.keymap.set("n", "<leader>dn", ":Noice dismiss<CR>")

-- Keymaps for barbar.nvim
-- Move to previous/next
vim.keymap.set(
	"n",
	"<A-,>",
	"<cmd>BufferPrevious<CR>",
	{ desc = "Move to previous buffer", noremap = true, silent = true }
)
vim.keymap.set("n", "<A-.>", "<cmd>BufferNext<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
-- Keymaps to pin buffer
vim.keymap.set("n", "<A-p>", "<cmd>BufferPin<CR>", { desc = "Pin focused buffer", noremap = true, silent = true })
-- Goto buffer in position _
vim.keymap.set("n", "<A-1>", "<cmd>BufferGoto 1<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-2>", "<cmd>BufferGoto 2<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-3>", "<cmd>BufferGoto 3<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-4>", "<cmd>BufferGoto 4<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-5>", "<cmd>BufferGoto 5<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-6>", "<cmd>BufferGoto 6<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-7>", "<cmd>BufferGoto 7<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-8>", "<cmd>BufferGoto 8<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-9>", "<cmd>BufferGoto 9<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<CR>", { desc = "Move to next buffer", noremap = true, silent = true })
-- Keymaps to close buffer
vim.keymap.set("n", "<A-q>", "<cmd>BufferClose<CR>", { desc = "Close focused buffer", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<A-Q>",
	"<cmd>BufferCloseAllButPinned<CR>",
	{ desc = "Close all buffer but pinned ones", noremap = true, silent = true }
)
-- Keymaps for ordering buffers
vim.keymap.set(
	"n",
	"<A-o>",
	"<cmd>BufferOrderByDirectory<CR>",
	{ desc = "Order files by directory", noremap = true, silent = true }
)

-- Keymaps for Gitsigns
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk <CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk <CR>", { desc = "Reset hunk" })

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x')
