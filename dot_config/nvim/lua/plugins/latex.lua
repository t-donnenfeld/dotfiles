return {
  "lervag/vimtex",
  lazy = false, -- don't lazy load, VimTeX must start with tex files
  init = function()
    vim.cmd([[
      filetype plugin indent on
      syntax enable
    ]])

    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-xelatex',
    }
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-xelatex"
      },
    }



    local map = vim.keymap.set

    map("n", "<leader>ll", ":VimtexCompile<CR>", { desc = "Vimtex Compile", silent = true, noremap = true })
    map("n", "<leader>lv", ":VimtexView<CR>", { desc = "Vimtex View", silent = true, noremap = true })
    map("n", "<leader>lc", ":VimtexClean<CR>", { desc = "Vimtex Clean", silent = true, noremap = true })
    map("n", "<leader>lt", ":VimtexTocToggle<CR>", { desc = "Vimtex Toc Toggle", silent = true, noremap = true })
    map("n", "<leader>le", ":VimtexErrors<CR>", { desc = "Vimtex Errors", silent = true, noremap = true })
    map("n", "<leader>lk", ":VimtexStop<CR>", { desc = "Vimtex Stop", silent = true, noremap = true })

    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_indent_enabled = 1
  end,
}
