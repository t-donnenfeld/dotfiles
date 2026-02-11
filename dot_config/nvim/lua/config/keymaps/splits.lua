local M = {}

function M.setup(map)
	local opts = { silent = true, noremap = true, desc = "Buffer" }

	-- Splits
	map("n", "<C-h>", "<C-w>h", opts)
	map("n", "<C-j>", "<C-w>j", opts)
	map("n", "<C-k>", "<C-w>k", opts)
	map("n", "<C-l>", "<C-w>l", opts)
	map("n", "<C-Up>", ":resize -4<CR>", opts)
	map("n", "<C-Down>", ":resize +4<CR>", opts)
	map("n", "<C-Left>", ":vertical resize -4<CR>", opts)
	map("n", "<C-Right>", ":vertical resize +4<CR>", opts)

	map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
	map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
	map("n", "<leader>so", ":only<CR>", { desc = "Close other splits" })
end

return M
