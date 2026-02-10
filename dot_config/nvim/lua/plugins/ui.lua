return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = { light = "latte", dark = "mocha" },
        transparent_background = false,
        term_colors = true,
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = true,
          which_key = true,
          lualine = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          fidget = true,
          toggleterm = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "dracula" } },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      notify = {
        enabled = false,
      },
      lsp = {
        signature = { enabled = false },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "Allaman/emoji.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    opts = {
      enable_cmp_integration = true,
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      local ts = require("telescope").load_extension("emoji")
      vim.keymap.set("n", "<leader>fe", ts.emoji, { desc = "[S]earch [E]moji" })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>mc", "<cmd>Trouble quickfix<CR>", desc = "Show build errors" },
    },
  },
  {
    "gu-fan/lastbuf.vim",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>z",
        function()
          vim.schedule(function()
            require("zen-mode").open()
          end)
        end,
        desc = "Zen Mode",
      },
      {
        "<Esc><Esc>",
        function()
          local ok, zen = pcall(require, "zen-mode")
          if ok then
            zen.close()
          end
        end,
        desc = "Exit Zen Mode",
      }
    },
    opts = {
      alacritty = {
        enabled = false,
        font = "16",
      },
      tmux = { enabled = true },
      window = {
        backdrop = 0.80,
        width = function()
          local cols = vim.o.columns
          local ratio = cols > 160 and 0.60 or 0.85
          return math.floor(cols * ratio)
        end
      },
    },
  }
}
