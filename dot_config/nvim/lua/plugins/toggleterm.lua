return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 10,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        direction = "horizontal",
        float_opts = {
          border = "curved",
          winblend = 0,
        },
        start_in_insert = true,
        close_on_exit = true,
        highlights = {
          Normal = { link = "Normal" },
          NormalFloat = { link = "NormalFloat" },
          FloatBorder = { link = "FloatBorder" },
        },
      })
      local map = vim.keymap.set
      map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
      map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })
      map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
    end,
}
