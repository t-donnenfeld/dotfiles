return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    require("plugins.formatters")
  end,
}
