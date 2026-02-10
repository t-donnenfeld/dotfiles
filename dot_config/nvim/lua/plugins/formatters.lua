return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  opts = {
    format_on_save = function(bufnr)
      return {
        timeout_ms = 1000,
        lsp_fallback = false,
      }
    end,
    notify_on_error = true,

    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" },
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      markdown = { "mdformat" },
      json = { "jq" },
      yaml = { "prettier" },
    },
    log_level = vim.log.levels.WARN,
  },

  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = false,
        })
      end,
      desc = "Format code (Conform)",
    },
  },
}

