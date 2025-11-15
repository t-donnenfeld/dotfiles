return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python"
  },
  keys = {
    { "<F5>",       function() require("dap").continue() end,          desc = "DAP: Start / Continue" },
    { "<F10>",      function() require("dap").step_over() end,         desc = "DAP: Step Over" },
    { "<F11>",      function() require("dap").step_into() end,         desc = "DAP: Step Into" },
    { "<F12>",      function() require("dap").step_out() end,          desc = "DAP: Step Out" },

    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
    { "<leader>dr", function() require("dap").repl.open() end,         desc = "DAP: Open REPL" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,     desc = "DAP: Run to Cursor" },
    { "<leader>du", function() require("dapui").toggle() end,          desc = "DAP: Toggle UI" },
    {
      "<leader>dr",
      function()
        if require("dap").session() then
          require("dap").terminate()
        end
        vim.defer_fn(function()
          require("dap").run_last()
        end, 100)
      end,
      desc = "DAP: Rerun last configuration"
    }
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
            { id = "scopes",      size = 0.40 },
            -- { id = "stacks",      size = 0.10 },
            { id = "breakpoints", size = 0.10 },
            -- { id = "watches",     size = 0.10 },
            { id = "console",     size = 0.50 },
          },
          size = 0.40,
          position = "right",
        },
        {
          elements = {
            "repl",
          },
          size = 15,
          position = "bottom",
        }
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
      vim.notify("🪲 Debug session ended — UI left open", vim.log.levels.INFO)
    end
    dap.listeners.before.event_exited["dapui_config"] = nil

    local lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/dap/languages"
    for _, file in ipairs(vim.fn.readdir(lang_dir)) do
      if file:match("%.lua$") then
        local ok, mod = pcall(require, "plugins.dap.languages." .. file:gsub("%.lua$", ""))
        if ok and type(mod) == "function" then mod(dap) end
      end
    end

    local function start_and_run_to_cursor()
      if not dap.session() then
        vim.notify("🐞 Starting debug session...", vim.log.levels.INFO)
        dap.continue()
        vim.defer_fn(function()
          dap.run_to_cursor()
        end, 300)
      else
        dap.run_to_cursor()
      end
    end

    -- Better, more visible icons for breakpoints and DAP state
    vim.fn.sign_define("DapBreakpoint", {
      text = "🔴",
      texthl = "DiagnosticError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
      text = "❓", -- question mark icon for conditional breakpoints
      texthl = "DiagnosticWarn",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "❌", -- red X
      texthl = "DiagnosticError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapLogPoint", {
      text = "", -- log icon
      texthl = "DiagnosticInfo",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "", -- arrow
      texthl = "DiagnosticHint",
      linehl = "Visual",
      numhl = "",
    })
  end,
}
