return {
	"echasnovski/mini.map",
	keys = {
		{ "<leader>m", "<cmd>lua MiniMap.toggle()<cr>", desc = "Toggle minimap" },
	},
	config = function()
		require("mini.map").setup({
			integrations = {
				require("mini.map").gen_integration.builtin_search(),
				require("mini.map").gen_integration.diagnostic(),
				require("mini.map").gen_integration.gitsigns(),
			},
			symbols = {
				encode = require("mini.map").gen_encode_symbols.dot("4x2"),
			},
			window = {
				width = 15,
				winblend = 25,
			},
		})
	end,
}
