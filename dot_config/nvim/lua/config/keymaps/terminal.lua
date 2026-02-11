local M = {}

function M.setup(map)
	-- Terminal
	map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
	map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Go to left window" })
	map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Go to lower window" })
	map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Go to upper window" })
	map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Go to right window" })
	map("t", "<C-l>", function()
		vim.api.nvim_feedkeys("clear" .. vim.api.nvim_replace_termcodes("<CR>", true, false, true), "t", false)
	end, { desc = "Clear terminal screen" })
end

return M
