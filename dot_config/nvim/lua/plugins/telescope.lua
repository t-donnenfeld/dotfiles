return {
  {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        file_browser = {
          hijack_netrw = true,
          hidden = true,
          respect_gitignore = false,
        },
      },
    })
    telescope.load_extension("file_browser")

    local map = vim.keymap.set
    map("n", "<leader>e", ":Telescope file_browser<CR>", { desc = "File browser (cwd)" })
    map("n", "<leader>E", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File browser (current file dir)" })
  end,
},
  {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim"  },
  keys = {
    { "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Help tags" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        layout_strategy = "flex",
        sorting_strategy = "ascending",
        prompt_prefix = "🔍 ",
      },
    })
  end,
}
}
