-- ============================================
-- COLORSCHEME / THEME
-- ============================================

return {
	-- Catppuccin (Active)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = { "bold" },
					keywords = { "italic" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = { "bold" },
					properties = {},
					types = { "bold" },
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					neo_tree = true,
					telescope = {
						enabled = true,
					},
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Tokyo Night (Commented)
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night",
	-- 			transparent = true,
	-- 			terminal_colors = true,
	-- 			styles = {
	-- 				comments = { italic = true },
	-- 				keywords = { italic = true },
	-- 				functions = { bold = true },
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },

	-- Kanagawa (Commented)
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			transparent = true,
	-- 			theme = "wave",
	-- 			background = {
	-- 				dark = "wave",
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end,
	-- },

	-- Rose Pine (Commented)
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "main",
	-- 			disable_background = true,
	-- 			disable_float_background = true,
	-- 			styles = {
	-- 				italic = true,
	-- 				bold = true,
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },

	-- Nightfox (Commented)
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			options = {
	-- 				transparent = true,
	-- 				terminal_colors = true,
	-- 				styles = {
	-- 					comments = "italic",
	-- 					keywords = "italic",
	-- 					functions = "bold",
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("nightfox")
	-- 	end,
	-- },

	-- Gruvbox Material (Commented)
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.g.gruvbox_material_transparent_background = 1
	-- 		vim.g.gruvbox_material_enable_italic = 1
	-- 		vim.g.gruvbox_material_enable_bold = 1
	-- 		vim.cmd.colorscheme("gruvbox-material")
	-- 	end,
	-- },

	-- Nord (Commented)
	-- {
	-- 	"shaunsingh/nord.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.nord_contrast = true
	-- 		vim.g.nord_borders = false
	-- 		vim.g.nord_disable_background = true
	-- 		vim.cmd.colorscheme("nord")
	-- 	end,
	-- },
}
