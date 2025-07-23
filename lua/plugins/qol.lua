return {
  {
    "folke/snacks.nvim", -- Collection of small QoL plugins
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      bigfile = { enabled = true },
      indent = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      notify = { enabled = true },
      image = { enabled = true },
      scope = { enabled = true },
      gitbrowse = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    "brenoprata10/nvim-highlight-colors", -- Add ability to preview colors
    config = function()
      vim.opt.termguicolors = true

      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "●",
        virtual_symbol_prefix = "",
        virtual_symbol_suffix = "",
        virtual_symbol_position = "eol",

        enable_hex = true,
        enable_short_hex = true,
        enable_rgb = true,
        enable_hsl = true,
        enable_ansi = true,
        enable_hsl_without_function = true,
        enable_var_usage = true,
        enable_named_colors = true,
        enable_tailwind = true,

        custom_colors = {},
        exclude_filetypes = {},
        exclude_buftypes = {},
        exclude_buffer = function(_) return false end,
      })

      local cmp = require("cmp")
      cmp.setup({ -- Add ability to suggest colors in tailwind for instance
        formatting = {
          format = require("nvim-highlight-colors").format
        },
      })
    end,
    event = "VeryLazy",
  },
  {
    "luukvbaal/statuscol.nvim", -- Helps removing foldlevel digits and customizing spacing
    enabled = true,
    event = "VeryLazy",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        setopt = true,
        segments = {
          { text = { builtin.foldfunc, "  " }, click = "v:lua.ScFa" }, -- folds + space
          { text = { "%s", " " }, click = "v:lua.ScSa" }, -- signs + space
          {
            text = { builtin.lnumfunc, "  " }, -- line numbers + space
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
        }

      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
