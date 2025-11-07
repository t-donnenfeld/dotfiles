local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local handlers = require("plugins.lsp.handlers")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "bashls", "clangd", "pyright" },
  automatic_installation = true,
  handlers = {
    function(server_name)
      vim.notify("Attaching handler for " .. server_name)
      local ok, extra = pcall(require, "plugins.lsp.servers." .. server_name)
      local bin = vim.fn.stdpath("data") .. "/mason/bin/" .. server_name
      local cmd = (vim.fn.executable(bin) == 1) and { bin } or { server_name }

      local cfg = vim.lsp.config({
        name = server_name,
        cmd = cmd,
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "package.json", "pyrightconfig.json" }),
      })

      if ok and type(extra) == "table" then
        cfg = vim.tbl_deep_extend("force", cfg, extra)
      end

      vim.lsp.start(cfg)
    end,
  }
})
