vim.lsp.config("vimls", {
  cmd = { "vim-language-server", "--stdio" },
  filetypes = { "vim", "vimrc" },
  root_markers = { ".git/" },

  settings = {
    vim = {
      isNeovim = true,
      suggest = {
        fromVimruntime = true,
        fromRuntimepath = true,
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
    },
  },
})
