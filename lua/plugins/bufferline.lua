return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<leader>bt", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle buffer pin" },
		{ "<leader>bD", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete unpinned buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete buffers right" },
		{ "<leader>bL", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete buffers left" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
	},
	opts = {
		options = {
			mode = "buffers",
			separator_style = "thin",
			always_show_bufferline = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			modified_icon = "●",
			color_icons = true,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and "󰅚" or "󰀪"
				return (" %s %d"):format(icon, count)
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = " Explorer",
					highlight = "Directory",
					text_align = "left",
					separator = true,
				},
			},
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
		},
	},
}
