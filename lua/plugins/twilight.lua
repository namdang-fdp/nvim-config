return {
	"folke/twilight.nvim",
	cmd = "Twilight",
	keys = {
		{ "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
	},
	config = function()
		require("twilight").setup({
			dimming = {
				alpha = 0.25,
				color = { "Normal", "#d7dae0" },
				term_bg = "#17181c",
				inactive = false,
			},
			context = 10,
			treesitter = true,
			expand = {
				"function",
				"method",
				"table",
				"if_statement",
			},
		})
	end,
}
