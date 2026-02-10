return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {}

		local grp = vim.api.nvim_create_augroup("NvimLintOnSave", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
			group = grp,
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>cl", function()
			require("lint").try_lint()
		end, { desc = "Run linters" })
	end,
}
