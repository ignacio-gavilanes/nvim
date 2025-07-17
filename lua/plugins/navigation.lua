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
  }
}
