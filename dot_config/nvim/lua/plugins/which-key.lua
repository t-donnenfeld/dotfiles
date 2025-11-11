return {
  "folke/which-key.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer local keymaps (which-key)",
    },
  },
  opts = {
    preset = "helix",
    spec = {
      { "<leader>f",  group = "+find" },
      { "<leader>e",  group = "+explore" },
      { "<leader>g",  group = "+git" },
      { "<leader>d",  group = "+debug" },
      { "<leader>dp", group = "+python" },
      { "<leader>l",  group = "+LaTeX" },
      { "<leader>c",  group = "+code" },
      { "<leader>cd", group = "+diagnostics" },
      { "<leader>t",  group = "+terminal" },
      { "<leader>s",  group = "+split" },
      { "<leader>b",  group = "+buffer" },
      { "<leader>w",  group = "+workspace" },
      { "<leader>v",  group = "+venv" },
      { "<leader>a",  group = "+avante" },
      { "<leader>q",  group = "+quit" },
    }
  }
}
