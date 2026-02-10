local map = vim.keymap.set

local function nnoremap(lhs, rhs)
	vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true })
end

require("config.keymaps.navigation").setup(nnoremap)
require("config.keymaps.buffers").setup(map)
require("config.keymaps.splits").setup(map)
require("config.keymaps.terminal").setup(map)
require("config.keymaps.misc").setup(map)
