local M = {}

function M.setup(map)
	-- Buffers
	map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
	map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
	map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
	map("n", "<leader>bD", ":bdelete!<CR>", { desc = "Delete buffer" })
	map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
	map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
	map("n", "<leader>bb", ":Telescope buffers<CR>", { desc = "List buffers" })
	map("n", "<leader>`", ":e#<CR>", { desc = "Last buffer" })
	map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close others" })
end

return M
