local keymap = vim.keymap.set


keymap("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap({ "t", "i" }, "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
keymap({ "t", "i" }, "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Go to bottom window" })
keymap({ "t", "i" }, "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Go to top window" })
keymap({ "t", "i" }, "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })

keymap("n", "<C-A-h>", "<cmd>vert res -5<CR>", { desc = "Resize window left" })
keymap("n", "<C-A-l>", "<cmd>vert res +5<CR>", { desc = "Resize window right" })
keymap("n", "<C-A-k>", "<cmd>res +5<CR>", { desc = "Resize window up" })
keymap("n", "<C-A-j>", "<cmd>res -5<CR>", { desc = "Resize window down" })

keymap("n", "<leader>dj", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })

keymap("n", "<leader>dk", function()
  vim.diagnostic.goto_prev()
end, { desc = "Previous diagnostic" })

keymap("n", "<leader>ds", function()
  vim.diagnostic.open_float(nil, {
    border = "single",
    focusable = false,
  })
end, { desc = "Show diagnostic under cursor" })

