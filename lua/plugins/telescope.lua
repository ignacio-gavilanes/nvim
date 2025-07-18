return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency
    {
      "nvim-telescope/telescope-fzf-native.nvim", -- fzf fuzzy finder for faster and more efficient searching
      build = 'make' -- Compiles the plugin from source using the `make` tool.
    },
  },

  config = function()
    local themes = require("telescope.themes")
    local builtin = require("telescope.builtin")

    local ivy_opts = themes.get_ivy({ winblend = 10 })
    local dropdown_opts = themes.get_dropdown({ previewer = false, winblend = 10 })

    require('telescope').setup {
      pickers = {
        find_files = themes.get_ivy(ivy_opts),
        live_grep = themes.get_ivy(ivy_opts),
        buffers = themes.get_ivy(ivy_opts),
        diagnostics = themes.get_ivy(ivy_opts),
        current_buffer_fuzzy_find = themes.get_dropdown(dropdown_opts),
      },
      extensions = {
        fzf = {}
      },
      defaults = {
        file_ignore_patterns = {
          "node_modules/*",
          "package%-lock.json",
          "lazy%-lock.json",
          "yarn.lock",
          "pnpm%-lock.yaml",
          "%[No Name%]",
        },
      },
    }

    require('telescope').load_extension('fzf')

    vim.keymap.set("n", "<space>ff", builtin.find_files, { desc = "Find file in project directory" })
    vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find word in project directory" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Navigate open buffers" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Navigate diagnostics, errors, warnings, etc" })
    vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzily search word in current buffer" })
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({ grep_open_files = true })
    end, { desc = "Find word in open buffers" })
  end
}
