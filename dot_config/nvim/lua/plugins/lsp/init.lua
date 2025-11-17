return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "stevanmilic/nvim-lspimport",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "vimls",
          "pyright",
          "bashls",
          "ts_ls",
          "clangd"
        },
        automatic_enable = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git", "compile_commands.json" },
      })
      vim.keymap.set("n", "<leader>ci", require("lspimport").import, { noremap = true })
    end,
  }
}
