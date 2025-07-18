local servers = {
  "lua_ls",
  "ts_ls",
  "ruby_lsp",
  "pyright",
  "graphql",
  "eslint",
  "jsonls",
  "html",
  "cssls",
  "tailwindcss",
  "yamlls",
}

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server in ipairs(servers) do
        if server == "lua_ls" then -- Get the lua_ls language server to recognize the vim global
          lspconfig[server].setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "Snacks" },
                },
              },
            },
          }
        else
          lspconfig[server].setup {
            capabilities = capabilities,
          }
        end
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- When hovering over an element I can press shift+k to see its documentation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- Go to definition
      --[[
        Keymap below enables code actions such as auto-import missing modules, rename variable,
        applying ESLint fixes, adding missing type annotations, etc
      ]]
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

