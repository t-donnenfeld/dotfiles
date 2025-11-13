return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
		}

		lint.linters.pylint.args = {
			"-f",
			"json",
			"--from-stdin",
			"%filepath",
			"--disable",
			"C0114,C0115,C0116",
		}

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
