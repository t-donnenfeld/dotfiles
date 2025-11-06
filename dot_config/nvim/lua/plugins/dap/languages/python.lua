return function(dap)
  local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
  local dap_python_ok, dap_python = pcall(require, "dap-python")

  if not dap_python_ok then
    vim.notify("[DAP] nvim-dap-python not found", vim.log.levels.ERROR)
    return
  end

  dap_python.setup(mason_debugpy)

  -- Auto-update adapter when venv changes
  vim.api.nvim_create_autocmd("User", {
    pattern = "VenvSelectActivated",
    callback = function(data)
      local python_path = data.venv_path or data.python or vim.fn.exepath("python3")
      dap_python.setup(python_path)
      vim.notify("[DAP] Using Python from: " .. python_path, vim.log.levels.INFO)
    end,
  })

  vim.keymap.set("n", "<leader>dpt", dap_python.test_method, { desc = "Debug Python test method" })
  vim.keymap.set("n", "<leader>dpT", dap_python.test_class, { desc = "Debug Python test class" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
      local active_venv = os.getenv("VIRTUAL_ENV") or vim.env.VIRTUAL_ENV
      local debugpy_exists = vim.fn.filereadable(mason_debugpy) == 1

      local msg = "🐍 Python DAP setup check:\n"
      msg = msg .. "• dap-python loaded: " .. (dap_python_ok and "✅" or "❌") .. "\n"
      msg = msg .. "• debugpy adapter: " .. (debugpy_exists and "✅ found" or "⚠️ missing") .. "\n"
      msg = msg .. "• active venv: " .. (active_venv and ("✅ " .. active_venv) or "⚠️ none") .. "\n"

      vim.schedule(function()
        vim.notify(msg, vim.log.levels.INFO, { title = "Python DAP Check" })
      end)
    end,
  })
end
