return {
  "lervag/vimtex",
  ft = {"tex"},
  config = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
        aux_dir = "aux",
        options = {
          "-pdf",
          "-interaction=nonstopmode"
        },
      }
    vim.g.vimtex_quickfix_mode = 0

    local map = vim.keymap.set

    map("n", "<leader>ll", ":VimtexCompile<CR>", {desc = "Vimtex Compile", silent = true, noremap = true })
    map("n", "<leader>lv", ":VimtexView<CR>", {desc = "Vimtex View", silent = true, noremap = true })     
    map("n", "<leader>lc", ":VimtexClean<CR>", {desc = "Vimtex Clean", silent = true, noremap = true })    
    map("n", "<leader>lt", ":VimtexTocToggle<CR>", {desc = "Vimtex Toc Toggle", silent = true, noremap = true })
    map("n", "<leader>le", ":VimtexErrors<CR>", {desc = "Vimtex Errors", silent = true, noremap = true })   
    map("n", "<leader>lk", ":VimtexStop<CR>", {desc = "Vimtex Stop", silent = true, noremap = true })     
  end,
}
