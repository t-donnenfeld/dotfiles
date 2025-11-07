return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local handlers = require("plugins.lsp.core.handlers") -- or _handlers

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "bashls", "clangd", "pyright" },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        local ok, extra = pcall(require, "plugins.lsp.servers." .. server)

        local opts = {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities,
        }

        if ok then
          opts = vim.tbl_deep_extend("force", opts, extra)
        end
        vim.lsp.config[server].setup(opts)
      end
    end,
  },
}
