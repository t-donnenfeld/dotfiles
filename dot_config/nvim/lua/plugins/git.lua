return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▎" },
			},
		},
		{
			"kdheepak/lazygit.nvim",
			cmd = "LazyGit",
			dependencies = { "nvim-lua/plenary.nvim" },
			keys = {
				{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
			},
		},
		{
			"sindrets/diffview.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				enhanced_diff_hl = true,
				use_icons = true,
				view = {
					merge_tool = {
						layout = "diff3_mixed",
					},
				},
			},
			keys = {
				{
					"<leader>gh",
					"<cmd>DiffviewFileHistory %<cr>",
					desc = "Diffview: File history",
				},
				{
					"<leader>gH",
					"<cmd>DiffviewFileHistory<cr>",
					desc = "Diffview: Repo history",
				},
				{
					"<leader>go",
					"<cmd>DiffviewOpen<cr>",
					desc = "Diffview: Open",
				},
				{
					"<leader>gc",
					"<cmd>DiffviewClose<cr>",
					desc = "Diffview: Close",
				},
				{
					"<leader>gs",
					"<cmd>DiffviewOpen HEAD<cr>",
					desc = "Diffview: HEAD vs Working",
				},
			},
		},
	},
}
