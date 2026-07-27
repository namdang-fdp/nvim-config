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
		{ "<leader>ee", "<cmd>Neotree toggle reveal left<cr>", desc = "Toggle file tree" },
		{ "<leader>er", "<cmd>Neotree reveal left<cr>", desc = "Reveal current file" },
		{ "<leader>gs", "<cmd>Neotree float git_status<cr>", desc = "Git status tree" },
	},
	opts = {
		popup_border_style = "rounded",
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
				hide_gitignored = true,
			},
			use_libuv_file_watcher = true,
		},
	},
}
