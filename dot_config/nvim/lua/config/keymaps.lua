local map = vim.keymap.set
local opts = { silent = true, noremap = true, desc = "Buffer" }

-- Style
vim.opt.fillchars = { vert = "│", horiz = "─", eob = " " }
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Buffers
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bb", ":Telescope buffers<CR>", { desc = "List buffers" })
map("n", "<leader>`", ":e#<CR>", { desc = "Last buffer" })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close others" })

-- Splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-Up>",    ":resize -2<CR>", opts)
map("n", "<C-Down>",  ":resize +2<CR>", opts)
map("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", ":split<CR>",  { desc = "Horizontal split" })
map("n", "<leader>so", ":only<CR>", { desc = "Close other splits" })

-- Highlights
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlights" })
