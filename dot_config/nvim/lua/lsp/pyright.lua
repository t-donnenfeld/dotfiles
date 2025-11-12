vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    python = {
      venvPath = vim.fn.expand("~/.virtualenvs"),
      venv = "venv",
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        stubPath = "typings",
        extraPaths = { "src", ".", "./venv/lib/python3.13/site-packages" },
      },
    },
  }
})
