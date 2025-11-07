local M = {}

function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  vim.notify("loaded handlers")
  -- LSP navigation
  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "gr", vim.lsp.buf.references, "List References")

  -- Code interaction
  map("n", "<leader>cd", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

  -- Diagnostics
  map("n", "<leader>cdd", vim.diagnostic.open_float, "Show Line Diagnostics")
  map("n", "<leader>cd<", vim.diagnostic.goto_prev, "Previous Diagnostic")
  map("n", "<leader>cd>", vim.diagnostic.goto_next, "Next Diagnostic")
  map("n", "<leader>cdq", vim.diagnostic.setloclist, "Open Quickfix List")

  -- Force Format
  map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format File")
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
