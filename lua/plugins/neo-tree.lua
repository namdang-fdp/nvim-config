-- ============================================
-- NEO-TREE - FILE EXPLORER
-- ============================================

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle reveal left<cr>", desc = "Toggle file tree" },
		{ "<leader>f", "<cmd>Neotree reveal left<cr>", desc = "Reveal current file" },
		{ "<leader>gs", "<cmd>Neotree float git_status<cr>", desc = "Git status tree" },
	},
	opts = {
		close_if_last_window = true,
		window = {
			width = 32,
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			use_libuv_file_watcher = true,
		},
	},
}
