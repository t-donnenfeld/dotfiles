vim.g.mapleader = ' '
vim.o.number = true

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true

vim.o.scrolloff = 10
vim.o.list = true

vim.o.confirm = true

vim.opt.laststatus = 3

-- NETRW
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 10
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_liststyle = 3


vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Lexplore")
end)


vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')

vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

vim.keymap.set("n", "<C-A-h>",  "<cmd>vert res -2<CR>")
vim.keymap.set("n", "<C-A-l>", "<cmd>vert res +2<CR>")
vim.keymap.set("n", "<C-A-k>",    "<cmd>res +2<CR>")
vim.keymap.set("n", "<C-A-j>",  "<cmd>res -2<CR>")

-- PLUGINS

vim.pack.add({ 'https://github.com/catppuccin/nvim' })
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })
vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })
vim.pack.add({ 'https://github.com/mason-org/mason-lspconfig.nvim' })
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth" },
})

require("which-key").setup()

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

require('lualine').setup({options = { theme = 'catppuccin' }})

require("mason").setup()
require("mason-lspconfig").setup {
ensure_installed = { "lua_ls" },
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("config"),
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(
        true,
        client.id,
        args.buf,
        { autotrigger = true }
      )
    end
  end,
})

vim.opt.completeopt = { "menu", "menuone", "noselect" }

--: treesitter

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

