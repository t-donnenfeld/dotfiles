return function(dap)
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local codelldb = mason_path .. "/bin/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.cpp = {
    {
      name = "🔹 Launch file with args",
      type = "codelldb",
      request = "launch",

      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,

      args = function()
        local input = vim.fn.input("Program arguments: ")
        return vim.split(input, " ", { trimempty = true })
      end,

      cwd = "${workspaceFolder}",
      stopOnEntry = false,

      runInTerminal = true,
    },
    {
      name = "🔹 Attach to process",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }

  dap.configurations.c = dap.configurations.cpp
end
