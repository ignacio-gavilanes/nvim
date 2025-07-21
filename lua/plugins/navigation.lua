return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },

    keys = { -- Global keybindings
      {
        "<leader>-",
        function()
          local oil = require("oil")
          if vim.bo.filetype == "oil" then
            vim.cmd.close()
          else
            oil.open_float(vim.loop.cwd())
          end
        end,
        desc = "Toggle Oil Float",
        mode = "n",
      },
    },

    opts = {
      default_file_explorer = true,
      delete_to_trash = true,

      float = {
        padding = 2,
        max_width = 0.9,
        max_height = 0.9,
        border = "rounded",
        win_options = { winblend = 0 },
      },

      win_options = {
        wrap = true,
        winblend = 0,
      },

      view_options = {
        show_hidden = true, -- Shows dot files
        natural_order = true, -- Show directories/files in a more human readable way
        is_always_hidden = function(name, _) -- List of files I do not want to see
          return name == ".." or name == ".git" or name == ".DS_Store"
        end,
      },

      keymaps = { -- Oil specific keybindings
        ["<Esc><Esc>"] = "actions.close",
        ["<leader>="] = {
          callback = function() -- Opens the current working directory in the existing buffer, replacing it instead of stacking new buffers.
            require("oil").open(vim.fn.getcwd(), { replace_buf = true })
          end,
          desc = "Go to Project Root",
        },
      }
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end,
    keys = function()
      local harpoon = require("harpoon")
      local snacks = require("snacks")

      return {
        {
          "<leader>a",
          function()
            harpoon:list():add()
            local filename = vim.fn.expand("%:t")

            if filename == "" then
              filename = "Buffer"
            end

            snacks.notify("Added " .. filename .. " to Harpoon", {
              title = "Harpoon",
              icon = "📌",
              level = "info"
            })
          end,
          desc = "Add file to Harpoon"
        },
        {
          "<leader>r",
          function()
            local filename = vim.fn.expand("%:t")

            if filename == "" then
              filename = "Buffer"
            end

            harpoon:list():remove()
            snacks.notify("Removed " .. filename .. " from Harpoon", {
              title = "Harpoon",
              icon = "🗑️",
              level = "warn"
            })
          end,
          desc = "Remove file from Harpoon"
        },
        {
          "<leader>h",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), {
              title = " 🎣 Harpoon Files ",
              ui_width_ratio = 0.40,
              ui_fallback_width = 80,
              ui_max_width = 120,
            })
          end,
          desc = "Toggle Harpoon Quick Menu"
        },
        {
          "<leader>1",
          function() harpoon:list():select(1) end,
          desc = "Navigate to Harpoon file 1"
        },
        {
          "<leader>2",
          function() harpoon:list():select(2) end,
          desc = "Navigate to Harpoon file 2"
        },
        {
          "<leader>3",
          function() harpoon:list():select(3) end,
          desc = "Navigate to Harpoon file 3"
        },
        {
          "<leader>4",
          function() harpoon:list():select(4) end,
          desc = "Navigate to Harpoon file 4"
        },
        {
          "<leader>5",
          function() harpoon:list():select(5) end,
          desc = "Navigate to Harpoon file 5"
        },
        {
          "<C-S-P>",
          function() harpoon:list():prev() end,
          desc = "Navigate to previous Harpoon file"
        },
        {
          "<C-S-N>",
          function() harpoon:list():next() end,
          desc = "Navigate to next Harpoon file"
        },
      }
    end,
  }
}
