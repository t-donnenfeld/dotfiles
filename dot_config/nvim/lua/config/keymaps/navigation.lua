local M = {}

function M.setup(nnoremap)
	-- Navigation
	nnoremap("<C-u>", "<C-u>zz")
	nnoremap("<C-d>", "<C-d>zz")
end

return M
