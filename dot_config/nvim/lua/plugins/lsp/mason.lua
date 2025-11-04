-- lua/plugins/lsp/mason.lua
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local handlers = require("plugins.lsp.handlers")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "bashls", "clangd", "pyright" },
  automatic_installation = true,

  -- ⬇️ new-style handler directly in setup()
  handlers = {
    function(server_name)
      local ok, conf = pcall(require, "plugins.lsp.settings." .. server_name)

      local cfg = vim.lsp.config({
        name = server_name,
        cmd = { server_name }, -- Mason path if needed
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "package.json" }),
      })

      if ok and type(conf) == "table" then
        cfg = vim.tbl_deep_extend("force", cfg, conf)
      end

      vim.lsp.start(cfg)
    end,
  },
})

