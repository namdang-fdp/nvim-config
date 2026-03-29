-- ============================================
-- UI ENHANCEMENTS
-- ============================================
return {
	-- ==================== COLORSCHEME ====================
	-- Option 1: Catppuccin (hiện tại - pastel, mềm mại)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				term_colors = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					telescope = true,
					which_key = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Option 2: Tokyo Night (cyberpunk, neon)
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night", -- storm, moon, night
	-- 			transparent = true,
	-- 			styles = {
	-- 				comments = { italic = true },
	-- 				keywords = { italic = true },
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },

	-- Option 3: Nightfox (đẹp, nhiều variant)
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			options = {
	-- 				transparent = true,
	-- 				styles = {
	-- 					comments = "italic",
	-- 					keywords = "bold",
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("carbonfox") -- carbonfox, nightfox, dawnfox, dayfox
	-- 	end,
	-- },

	-- Option 4: Rose Pine (vintage, elegant)
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "moon", -- main, moon, dawn
	-- 			disable_background = true,
	-- 			disable_float_background = true,
	-- 		})
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },

	-- ==================== STATUS LINE ====================
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin", -- Đổi theo colorscheme
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true, -- Status line chung cho tất cả windows
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } }, -- Show relative path
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	-- ==================== BUFFER LINE ====================
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					separator_style = "slant", -- slant, thick, thin, slope
					always_show_bufferline = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					color_icons = true,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							highlight = "Directory",
							text_align = "left",
							separator = true,
						},
					},
					-- Hover highlights
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
				},
			})
		end,
	},

	-- ==================== INDENT GUIDES ====================
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				highlight = { "Function", "Label" },
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
				},
			},
		},
	},

	-- ==================== WHICH-KEY ====================
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				window = {
					border = "rounded",
					position = "bottom",
				},
			})
		end,
	},

	-- ==================== BONUS: NOTIFICATIONS ====================
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				fps = 60,
				render = "compact", -- default, minimal, simple, compact
				timeout = 3000,
				top_down = false,
			})
			vim.notify = require("notify")
		end,
	},

	-- ==================== BONUS: NOICE (fancy UI) ====================
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
	},

	-- ==================== BONUS: DASHBOARD ====================
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local quotes = {
				"Code with passion, debug with patience",
				"Make it work, make it right, make it fast",
				"First, solve the problem. Then, write the code",
				"Coffee + Code = Magic",
				"Bug-free is a myth, handled bugs are reality",
				"Talk is cheap. Show me the code. - Linus Torvalds",
				"Any fool can write code that a computer can understand. Good programmers write code that humans can understand.",
			}

			local function get_random_quote()
				math.randomseed(os.time())
				return quotes[math.random(#quotes)]
			end

			dashboard.section.header.val = {
				"                                                                       ",
				" ███╗   ██╗ █████╗ ███╗   ███╗██████╗  █████╗ ███╗   ██╗ ██████╗     ",
				" ████╗  ██║██╔══██╗████╗ ████║██╔══██╗██╔══██╗████╗  ██║██╔════╝     ",
				" ██╔██╗ ██║███████║██╔████╔██║██║  ██║███████║██╔██╗ ██║██║  ███╗    ",
				" ██║╚██╗██║██╔══██║██║╚██╔╝██║██║  ██║██╔══██║██║╚██╗██║██║   ██║    ",
				" ██║ ╚████║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║██║ ╚████║╚██████╔╝    ",
				" ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝     ",
				"                                                                       ",
				"  ██████╗ ██████╗ ██████╗ ███████╗██████╗                             ",
				" ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗                            ",
				" ██║     ██║   ██║██║  ██║█████╗  ██████╔╝                            ",
				" ██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗                            ",
				" ╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║                            ",
				"  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝                            ",
				"                                                                       ",
				"              [ " .. get_random_quote() .. " ]                        ",
				"                                                                       ",
			}
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			alpha.setup(dashboard.opts)
		end,
	},
}
