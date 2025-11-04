return {
  "lervag/vimtex",
  ft = "tex",
  config = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_quickfix_mode = 0

    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
    vim.o.foldtext = "vimtex#fold#text()"

    local map = vim.keymap.set
    local opts = { silent = true, noremap = true }

    map("n", "<leader>ll", ":VimtexCompile<CR>", {opts..., description = "Vimtex Compile"})  
    map("n", "<leader>lv", ":VimtexView<CR>", opts)     
    map("n", "<leader>lc", ":VimtexClean<CR>", opts)    
    map("n", "<leader>lt", ":VimtexTocToggle<CR>", opts)
    map("n", "<leader>le", ":VimtexErrors<CR>", opts)   
    map("n", "<leader>lk", ":VimtexStop<CR>", opts)     

    -- Optional: set local leader to comma for vimtex
    vim.g.maplocalleader = ","
  end,
}
