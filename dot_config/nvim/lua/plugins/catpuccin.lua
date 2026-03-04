require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    cmp = true,
    which_key = true,
    mason = true,
    treesitter = true,
    telescope = true,
    native_lsp = {
      enabled = true,
      virtual_text = { errors = {}, warnings = {}, hints = {}, information = {} },
      underlines = { errors = {}, warnings = {}, hints = {}, information = {} },
    },
  },
})

require('lualine').setup({
  options = { theme = 'catppuccin' }
})

vim.cmd.colorscheme "catppuccin"
local palette = require("catppuccin.palettes").get_palette()

-- Highlights

vim.api.nvim_set_hl(0, "WarningMsg", { fg = palette.peach, bold = true })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.blue, bg = palette.mantle })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = palette.mantle })
vim.api.nvim_set_hl(0, "CursorLine",  { bg = palette.surface0 })
vim.api.nvim_set_hl(0, "Directory",   { fg = palette.blue, bold = true })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = palette.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = palette.peach })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = palette.teal })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = palette.sky })
