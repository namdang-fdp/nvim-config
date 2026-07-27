return {
	"sindrets/diffview.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
		{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
		{ "<leader>gfh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
		{ "<leader>gfH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			default = {
				layout = "diff2_horizontal",
			},
			merge_tool = {
				layout = "diff3_horizontal",
			},
			file_history = {
				layout = "diff2_horizontal",
			},
		},
	},
}
