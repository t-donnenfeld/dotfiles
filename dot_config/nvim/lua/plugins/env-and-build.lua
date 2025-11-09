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
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    keys = {
      { "<leader>m",  "<cmd>Telescope overseer<CR>",   desc = "Run Makefile task" },
      { "<leader>mr", "<cmd>OverseerRun make run<CR>", desc = "Run make run" },
      { "<leader>mt", "<cmd>OverseerToggle<CR>",       desc = "Toggle task list" },
    },
    config = function()
      local overseer = require("overseer")
      overseer.setup()
      require("telescope").load_extension("overseer")
    end
  }
}
