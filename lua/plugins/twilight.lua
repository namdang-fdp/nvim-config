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
				color = { "Normal", "#dcd7ba" },
				term_bg = "#181616",
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
