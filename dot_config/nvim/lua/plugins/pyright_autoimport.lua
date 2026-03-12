local function pyright_extra_settings()
  return {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.pyright = vim.tbl_deep_extend(
        "force",
        opts.servers.pyright or {},
        pyright_extra_settings()
      )
    end,
  },
}
