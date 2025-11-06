return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
  },
  ft = "python",                                                                                       -- Load when opening Python files
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<CR>", desc = "Select Python venv" }
  },
  opts = {
    search = {},
    options = {}
  },
}
