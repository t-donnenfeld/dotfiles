vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("%:p") ~= "" then
      vim.cmd("silent! lcd " .. vim.fn.expand("%:p:h"))
    end
  end,
})
