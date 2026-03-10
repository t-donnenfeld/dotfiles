return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      opts.server = opts.server or {}
      opts.server.on_attach = function(_, bufnr)
        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Rust Code Action", buffer = bufnr })
      end
    end,
  },
}
