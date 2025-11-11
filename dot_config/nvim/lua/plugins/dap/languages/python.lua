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
end
