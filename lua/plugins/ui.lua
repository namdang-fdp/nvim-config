return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "kanagawa",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { statusline = { "alpha" } },
			},
			sections = {
				lualine_a = { { "mode", fmt = function(value) return value:sub(1, 1) end } },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1, symbols = { modified = " ●", readonly = " " } } },
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
				highlight = "Identifier",
			},
			exclude = {
				filetypes = {
					"alpha",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"Trouble",
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				preset = "classic",
				delay = 300,
				win = {
					border = "rounded",
					padding = { 1, 2 },
					wo = { winblend = 0 },
				},
			})
			wk.add({
				{ "<leader>b", group = "Buffers" },
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>e", group = "Explorer" },
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "Language" },
				{ "<leader>lg", group = "Go" },
				{ "<leader>lj", group = "Java" },
				{ "<leader>lp", group = "Python" },
				{ "<leader>p", group = "Projects" },
				{ "<leader>t", group = "Terminal / Tests" },
				{ "<leader>u", group = "UI toggles" },
				{ "<leader>x", group = "Diagnostics" },
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			background_colour = "#211f1c",
			fps = 30,
			render = "compact",
			stages = "fade_in_slide_out",
			timeout = 2500,
			top_down = false,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},
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
				hover = { enabled = true },
				signature = { enabled = true },
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			views = {
				cmdline_popup = {
					border = { style = "rounded" },
					win_options = { winblend = 0 },
				},
				popupmenu = {
					border = { style = "rounded" },
					win_options = { winblend = 0 },
				},
				hover = {
					border = { style = "rounded" },
					win_options = { winblend = 0 },
				},
			},
		},
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		cond = function()
			return vim.fn.argc() == 0
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                                      ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                      ",
				"            graphite · amber · focused               ",
			}
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find files", "<cmd>Telescope find_files<cr>"),
				dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
				dashboard.button("p", "  Find projects", "<cmd>FindProjects<cr>"),
				dashboard.button("g", "  Search text", "<cmd>Telescope live_grep<cr>"),
				dashboard.button("c", "  Neovim config", "<cmd>edit $MYVIMRC<cr>"),
				dashboard.button("q", "  Quit", "<cmd>quitall<cr>"),
			}
			dashboard.section.footer.val = "Warm contrast for long coding sessions"
			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end,
	},
}
