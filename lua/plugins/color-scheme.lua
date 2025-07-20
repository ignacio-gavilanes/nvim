return { -- solarized-osaka colorscheme by devaslife
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    on_highlights = function(hl, c)
      -- GitSigns highlights (gutter colors)
      hl.GitSignsAdd = { fg = "#a6e22e", bold = true }
      hl.GitSignsChange = { fg = "#fd971f", italic = true }
      hl.GitSignsDelete = { fg = "#f92672", underline = true }

      -- GitSigns word-level diff highlighting
      hl.GitSignsAddInline = { fg = "#a6e22e", bg = "#3d4f32", bold = true }
      hl.GitSignsChangeInline = { fg = "#fd971f", bg = "#4f3f32", italic = true }
      hl.GitSignsDeleteInline = { fg = "#f92672", bg = "#4f3239", underline = true }

      -- Yank and Visual mode highlighting
      hl.IncSearch = { fg = "#fd971f", bg = "#4f3f32", italic = true }
      hl.Visual = { fg = "#fd971f", bg = "#4f3f32", italic = true }

      -- Telescope customization
      local bg = "#002b36"
      local fg = "#87DBDE"

      hl.TelescopeNormal = { bg = bg, fg = fg }
      hl.TelescopeBorder = { bg = bg, fg = bg }
      hl.TelescopePromptNormal = { bg = bg }
      hl.TelescopePromptBorder = { bg = bg, fg = bg }
      hl.TelescopePromptTitle = { bg = bg, fg = bg }
      hl.TelescopePreviewTitle = { bg = bg, fg = bg }
      hl.TelescopeResultsTitle = { bg = bg, fg = bg }
    end,
  },
  config = function(_, opts)
    require("solarized-osaka").setup(opts)
    vim.cmd.colorscheme("solarized-osaka")
  end,
}
