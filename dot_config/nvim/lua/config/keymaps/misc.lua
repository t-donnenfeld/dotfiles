local M = {}

function M.setup(map)
	-- Highlights
	map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlights" })

	-- CWD
	map("n", "<leader>wd", ":cd %:p:h<CR>:pwd<CR>", {
		desc = "Change CWD to current file's directory",
	})
end

return M
