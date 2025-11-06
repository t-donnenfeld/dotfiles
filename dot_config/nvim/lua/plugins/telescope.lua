return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim", "nvim-telescope/telescope-dap.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    keys = {

      -- TELESCOPE
      { "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg",       "<cmd>Telescope live_grep<CR>",  desc = "Live grep" },
      { "<leader>fb",       "<cmd>Telescope buffers<CR>",    desc = "Find buffers" },
      { "<leader>fh",       "<cmd>Telescope help_tags<CR>",  desc = "Help tags" },
      {
        "<leader>fc",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "  Neovim Config",
            cwd = vim.fn.stdpath("config"),
            hidden = true,
          })
        end,
        desc = "Browse nvim config with Telescope",
      },

      -- TELESCOPE FILE BROWSER
      { "<leader>ee", "<cmd>Telescope file_browser<CR>",                               desc = "File browser (cwd)" },
      { "<leader>eE", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File browser (current file dir)" },
      {
        "<leader>ec",
        function()
          local path = vim.fn.stdpath("config")
          require("telescope").extensions.file_browser.file_browser({ path = path })
        end,
        desc = "File browser (NVIM config directory)",
      },
      { "<leader>em", "<cmd>Telescope file_browser path=/home/theo/.local/share/chezmoi select_buffer=true<CR>", desc = "File browser (Chezmoi Git Repo)" },
    },
    config = function()
      local actions = require("telescope.actions")
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          layout_strategy = "flex",
          sorting_strategy = "ascending",
          prompt_prefix = "🔍 ",
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
              ["<C-S-j>"] = actions.preview_scrolling_down,
              ["<C-S-k>"] = actions.preview_scrolling_up,
            }
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            hidden = true,
            respect_gitignore = false,
          },
        },
      })
      telescope.load_extension("dap")
      telescope.load_extension("file_browser")
    end,
  }
}
