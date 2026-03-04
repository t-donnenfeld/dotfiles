require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "ruff",
    "basedpyright"
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("config"),
          vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
})

vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.cfg",
    "setup.py",
    ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode       = "standard",
        autoSearchPaths        = true,
        useLibraryCodeForTypes = true,
        diagnosticMode         = "workspace",
        autoImportCompletions  = true,
      },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
  init_options = {
    settings = {
      lineLength      = 88,
      fixAll          = true,
      organizeImports = true,
    },
  },
})

vim.lsp.enable({ "basedpyright", "ruff" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(event)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gr", vim.lsp.buf.references, "List references")
    map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")

    map("n", "K", vim.lsp.buf.hover, "Hover docs")
    map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help (insert)")

    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

    map({ "n", "v" }, "<leader>cf", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client) return client.name == "ruff" end,
      })
    end, "Format buffer/selection")

    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
  end,
})

vim.diagnostic.config({
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float            = {
    border    = "rounded",
    source    = true,
    focusable = false,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspCompletion", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, {
        autotrigger = true, -- trigger after ".", "(", etc.
      })
    end
  end,
})

