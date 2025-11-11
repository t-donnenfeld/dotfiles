return {
  "3rd/image.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("image").setup({
      backend = "ueberzug",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto", "txt" },
        },
        neorg = { enabled = true },
      },
      max_width = 100,
      max_height = 50,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      editor_only_render_when_focused = true,
    })
  end,
}
