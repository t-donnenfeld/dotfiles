return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")

		conform.setup({
			notify_on_error = true,
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				markdown = { "mdformat" },
				json = { "jq" },
				yaml = { "yamlfmt" },
			},

			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = false,
			},

			log_level = vim.log.levels.WARN,
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({ async = true, lsp_fallback = true })
		end, { desc = "Format code" })
	end,
}
