return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-telescope/telescope.nvim" },
	opts = function()
		return {
			input = {
				enabled = true,
				default_prompt = "➤ ",
				border = "rounded",
				win_options = { winblend = 0 },
			},
			select = {
				enabled = true,
				backend = { "telescope", "builtin" },
				telescope = require("telescope.themes").get_dropdown({
					borderchars = {
						"─",
						"│",
						"─",
						"│",
						"╭",
						"╮",
						"╯",
						"╰",
					},
				}),
			},
		}
	end,
}
