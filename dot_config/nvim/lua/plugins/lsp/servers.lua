local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local handlers = require("plugins.lsp.handlers")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "bashls", "clangd", "pyright" },
  automatic_installation = true,

  handlers = {
    function(server_name)
      local ok, extra = pcall(require, "plugins.lsp.settings." .. server_name)

      local cfg = vim.lsp.config({
        name = server_name,
        cmd = { server_name },
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "package.json" }),
      })

      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/" .. server_name
      if vim.fn.executable(mason_bin) == 1 then
        cfg.cmd = { mason_bin }
      end

      if ok and type(extra) == "table" then
        cfg = vim.tbl_deep_extend("force", cfg, extra)
      end

      vim.lsp.start(cfg)
    end,
  },
})

