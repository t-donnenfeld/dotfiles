return {
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },

    config = function()
      require("remote-sshfs").setup({})
    end,

    keys = function()
      local api = require("remote-sshfs.api")
      local connections = require("remote-sshfs.connections")
      local builtin = require("telescope.builtin")

      return {
        -- Connect (host picker)
        {
          "<leader>rc",
          api.connect,
          desc = "Remote SSHFS: Connect",
        },

        -- Disconnect
        {
          "<leader>rd",
          api.disconnect,
          desc = "Remote SSHFS: Disconnect",
        },

        -- Edit ~/.ssh/config
        {
          "<leader>re",
          api.edit,
          desc = "Remote SSHFS: Edit SSH config",
        },

        -- Remote-aware telescope: find files
        {
          "<leader>rf",
          function()
            if connections.is_connected() then
              api.find_files()
            else
              builtin.find_files()
            end
          end,
          desc = "Remote SSHFS: Find files",
        },

        -- Remote-aware telescope: live grep
        {
          "<leader>rg",
          function()
            if connections.is_connected() then
              api.live_grep()
            else
              builtin.live_grep()
            end
          end,
          desc = "Remote SSHFS: Live grep",
        },
      }
    end,
  },
}
