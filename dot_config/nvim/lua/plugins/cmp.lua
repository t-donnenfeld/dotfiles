local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp', max_item_count = 8 },
    { name = 'buffer',   max_item_count = 5 },
    { name = 'path',     max_item_count = 3 },
  },

  window = {
    completion = cmp.config.window.bordered({
      border = "rounded",
      winblend = 5,
    }),
    documentation = cmp.config.window.bordered({
      border = "rounded",
      winblend = 5,
    }),
  },

  mapping = cmp.mapping.preset.insert(),
})
