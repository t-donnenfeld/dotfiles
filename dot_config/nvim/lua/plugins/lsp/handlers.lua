local M = {}

function M.on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  local map = vim.keymap.set
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
