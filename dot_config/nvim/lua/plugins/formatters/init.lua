return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      local conform = require("conform")

      local formatters_by_ft = {}
      local dir = vim.fn.stdpath("config") .. "/lua/plugins/formatters/languages"

      for _, file in ipairs(vim.fn.readdir(dir)) do
        if file:match("%.lua$") then
          local ok, mod = pcall(require, "plugins.formatters.languages." .. file:gsub("%.lua$", ""))
          if ok and type(mod) == "table" then
            for ft, fmts in pairs(mod) do
              formatters_by_ft[ft] = fmts
            end
          end
        end
      end

      conform.setup({
        formatters_by_ft = formatters_by_ft,
        format_on_save = function(bufnr)
          if vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "" then
            return
          end
          return { timeout_ms = 2000, lsp_fallback = true }
        end,
      })
    end,
  },
}
