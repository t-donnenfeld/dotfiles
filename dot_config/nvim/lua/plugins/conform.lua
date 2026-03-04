local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({
    lsp_fallback = true,
    async = true,
  })
end, { desc = "Format file" })
