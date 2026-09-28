return {
  -- Autocomplete
  {
    "Saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Saghen/blink.cmp",
    },

    config = function()
      vim.diagnostic.config({
        -- Floating code text
        virtual_text = false,
        -- Left gutter diagnostics
        signs = false,
        -- Underline diagnostics
        underline = false,
        severity_sort = true,
      })

      require("mason").setup()

      -- Language servers
      local servers = {
        "clangd",
        "jdtls",
        "ts_ls",
        "basedpyright",
        "cssls",
        "html",
        "lua_ls",
        "dockerls",
        "docker_compose_language_service",
        "yamlls",
        "jsonls",
        "bashls",
        "tflint",
        "terraformls",
        "marksman",
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
        vim.lsp.enable(server)
      end -- end for

    end, -- config end
  },
}
