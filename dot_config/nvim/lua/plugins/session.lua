return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize" },
    pre_save = function()
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
    end,
  },
  keys = {
    {
      "<leader>qa",
      function()
        require("persistence").stop()
        require("persistence").save()
        vim.cmd("qa")
      end,
      desc = "Quit and Save Session",
    },
    {
      "<leader>qq",
      function()
        require("persistence").stop()
        vim.cmd("qa!")
      end,
      desc = "Quit without Saving Session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load()
      end,
      desc = "Load Last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Load Directory Session",
    },
  },
}
