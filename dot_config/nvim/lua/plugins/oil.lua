require("oil").setup({
  default_file_explorer = true,
  keymaps = {
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-h>"] = "actions.parent",
    ["q"] = "actions.close",
  },
  confirmation = {
    border = "single",
    win_options = {
      winblend = 10,
    },
  }
})

local oil_win = nil

vim.keymap.set("n", "<leader>e", function()
  if oil_win and vim.api.nvim_win_is_valid(oil_win) then
    vim.api.nvim_win_close(oil_win, true)
    oil_win = nil
  else
    vim.cmd("vert leftabove split")
    vim.cmd("vertical resize 25")
    require("oil").open()
    oil_win = vim.api.nvim_get_current_win()
  end
end)
