return {
  "lewis6991/gitsigns.nvim",
  opts = {
    count_chars = { "", "󰬻", "󰬼", "󰬽", "󰬾", "󰬿", "󰭀", "󰭁", "󰭂", ["+"] = "󰿮" },
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "", show_count = true },
      topdelete = { text = "", show_count = true },
      changedelete = { text = "┃", show_count = true },
    },
    current_line_blame = true,
    current_line_blame_formatter = "    <author>, <author_time:%R> - <summary>",
    signcolumn = true,
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(args)
        local mode = args.mode
        local trigger = args.trigger
        local action = args.action
        local description = args.description or ""
        local opts = { buffer = bufnr, desc = description }
        vim.keymap.set(mode, trigger, action, opts)
      end

      map({
        mode = 'n',
        trigger = ']c',
        action = function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end,
        description = "Go to next hunk",
      })

      map({
        mode = 'n',
        trigger = '[c',
        action = function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end,
        description = "Go to previous hunk",
      })

      map({
        mode = 'n',
        trigger = '<leader>gp',
        action = gitsigns.preview_hunk,
        description = "Preview hunk",
      })

      map({
        mode = 'n',
        trigger = '<leader>gi',
        action = gitsigns.preview_hunk_inline,
        description = "Preview hunk inline"
      })

      map({
        mode = 'n',
        trigger = '<leader>gd',
        action = function()
          gitsigns.diffthis('~')
        end,
        description = "Preview diff",
      })

      map({
        mode = 'n',
        trigger = '<leader>gb',
        action = gitsigns.toggle_current_line_blame,
        description = "Toggle blame",
      })

      map({
        mode = 'n',
        trigger = '<leader>gw',
        action = gitsigns.toggle_word_diff,
        description = "Toggle word-level diff highlighting",
      })
    end
  },
}

