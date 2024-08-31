-- Lualine component for new, untracked files
local function is_new_file()
	local filepath = vim.fn.expand('%:p')
	if vim.fn.empty(filepath) == 1 then
		return ''
	end

	local git_command = 'git ls-files --error-unmatch ' .. filepath .. ' 2>/dev/null'
	vim.fn.systemlist(git_command)

	return vim.v.shell_error ~= 0 and '[NEW]' or ''
end

local colors = {
	-- Normal mode
	cyan_bg = "#113B3D",
	cyan_fg = "#87DADE",
	-- Replace mode
	magenta_bg = "#541132",
	magenta_fg = "#E580B2",
	-- Visual mode
	orange_bg = "#5C2209",
	orange_fg = "#F19A74",
	-- Insert mode
	green_bg = "#2C3300",
	green_fg = "#EDFF80",
	-- Command mode
	blue_bg = "#103956",
	blue_fg = "#7EBBE7",
	-- Background
	solarized_bg = "#001115",
	-- inactive
	solarized_fg = "#586D75",
}

-- Custom Lualine theme
local solarized_bubbles_theme = {
	normal = {
		a = { bg = colors.cyan_bg, fg = colors.cyan_fg, gui = "bold" },
		b = { bg = colors.solarized_bg, fg = colors.cyan_fg, },
		c = { fg = colors.cyan_fg, },
	},

	replace = {
		a = { bg = colors.magenta_bg, fg = colors.magenta_fg, gui = "bold" },
		b = { bg = colors.solarized_bg, fg = colors.magenta_fg, },
		c = { fg = colors.magenta_fg, },
	},

	visual = {
		a = { bg = colors.orange_bg, fg = colors.orange_fg, gui = "bold" },
		b = { bg = colors.solarized_bg, fg = colors.orange_fg, },
		c = { fg = colors.orange_fg, },
	},

	insert = {
		a = { bg = colors.green_bg, fg = colors.green_fg, gui = "bold" },
		b = { bg = colors.solarized_bg, fg = colors.green_fg, },
		c = { fg = colors.green_fg, },
	},

	command = {
		a = { bg = colors.blue_bg, fg = colors.blue_fg, gui = 'bold' },
		b = { bg = colors.solarized_bg, fg = colors.blue_fg },
		c = { fg = colors.blue_fg }
	},

	inactive = {
		a = { bg = colors.solarized_bg, fg = colors.solarized_fg, },
		b = { bg = colors.solarized_bg, fg = colors.solarized_fg, },
		c = { fg = colors.solarized_fg, },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	ependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = solarized_bubbles_theme,
			component_separators = '',
			section_separators = { left = '', right = '' },
		},
		sections = {
			lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
			lualine_b = { 'filename', is_new_file, 'branch' },
			lualine_c = {},
			lualine_x = {},
			lualine_y = { 'filetype', 'progress' },
			lualine_z = {
				{ 'location', separator = { right = '' }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = { 'filename' },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { 'location' },
		},
		tabline = {},
		extensions = { "neo-tree" }, -- Enhance the look of lualine for when navigating fs
	},
}
