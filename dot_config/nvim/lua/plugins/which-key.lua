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
      { "<leader>f", group = "+file" },
      { "<leader>e", group = "+explore" },
      { "<leader>g", group = "+git" },
      { "<leader>d", group = "+debug" },
      { "<leader>l", group = "+lsp" },
      { "<leader>c", group = "+code" },
      { "<leader>t", group = "+terminal" },
      { "<leader>s", group = "+split" },
      { "<leader>b", group = "+buffer" },
    }
  }
}
