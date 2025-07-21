return { -- solarized-osaka colorscheme by devaslife
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    on_highlights = function(hl)
      local bg = "#002b36"
      local fg = "#87DBDE"
      local bg_green = "#3d4f32"
      local fg_green = "#a6e22e"
      local bg_pink = "#4f3239"
      local fg_pink = "#f92672"
      local bg_orange = "#4f3f32"
      local fg_orange = "#fd971f"

      -- GitSigns highlights (gutter colors)
      hl.GitSignsAdd = { fg = fg_green, bold = true }
      hl.GitSignsChange = { fg = fg_orange, italic = true }
      hl.GitSignsDelete = { fg = fg_pink, underline = true }

      -- GitSigns word-level diff highlighting
      hl.GitSignsAddInline = { fg = fg_green, bg = bg_green, bold = true }
      hl.GitSignsChangeInline = { fg = fg_orange, bg = bg_orange, italic = true }
      hl.GitSignsDeleteInline = { fg = fg_pink, bg = bg_pink, underline = true }

      -- Yank and Visual mode highlighting
      hl.IncSearch = { fg = fg_orange, bg = bg_orange, italic = true }
      hl.Visual = { fg = fg_orange, bg = bg_orange, italic = true }

      -- Telescope customization
      hl.TelescopeNormal = { bg = bg, fg = fg }
      hl.TelescopeBorder = { bg = bg, fg = bg }
      hl.TelescopePromptNormal = { bg = bg }
      hl.TelescopePromptBorder = { bg = bg, fg = bg }
      hl.TelescopePromptTitle = { bg = bg, fg = bg }
      hl.TelescopePreviewTitle = { bg = bg, fg = bg }
      hl.TelescopeResultsTitle = { bg = bg, fg = bg }

      -- TODO: Customize Harpoon2 looks
    end,
  },
  config = function(_, opts)
    require("solarized-osaka").setup(opts)
    vim.cmd.colorscheme("solarized-osaka")
  end,
}
