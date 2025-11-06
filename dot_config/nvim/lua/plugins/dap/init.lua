return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python"
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "python", "cppdbg" },
      automatic_installation = true,
    })

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.55 },
            { id = "stacks",      size = 0.20 },
            { id = "breakpoints", size = 0.15 },
            { id = "watches",     size = 0.10 },
          },
          size = 0.40,
          position = "right",
        },
        {
          -- Bottom panel (optional)
          elements = {
            "repl",
            "console",
          },
          size = 0.20,
          position = "bottom",
        },
      },

      floating = {
        border = "none",
        mappings = { close = { "q", "<Esc>" } },
      },

      -- 🔘 Optional control icons at the bottom REPL
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⤵",
          step_over = "⤴",
          step_out = "⤶",
          terminate = "■",
        },
      },

      expand_lines = true, -- makes variable display multi-line if needed
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/dap/languages"
    for _, file in ipairs(vim.fn.readdir(lang_dir)) do
      if file:match("%.lua$") then
        local ok, mod = pcall(require, "plugins.dap.languages." .. file:gsub("%.lua$", ""))
        if ok and type(mod) == "function" then mod(dap) end
      end
    end

    local map = vim.keymap.set
    map("n", "<F5>", dap.continue, { desc = "Start/Continue" })
    map("n", "<F10>", dap.step_over, { desc = "Step Over" })
    map("n", "<F11>", dap.step_into, { desc = "Step Into" })
    map("n", "<F12>", dap.step_out, { desc = "Step Out" })
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
  end,
}
