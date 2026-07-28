return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ [[<C-\>]], "<cmd>1ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
			{ "<leader>tt", "<cmd>1ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
			{ "<leader>tf", "<cmd>1ToggleTerm direction=float<cr>", desc = "Float terminal" },
			{ "<leader>th", "<cmd>2ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
			{ "<leader>tv", "<cmd>3ToggleTerm direction=vertical size=80<cr>", desc = "Vertical terminal" },
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.4)
				end
			end,
			open_mapping = nil,
			hide_numbers = true,
			shade_terminals = false,
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = false,
			persist_size = true,
			persist_mode = false,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "rounded",
				winblend = 0,
				width = function()
					return math.floor(vim.o.columns * 0.8)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.7)
				end,
			},
			on_open = function(term)
				if term.id == 1 then
					vim.keymap.set("t", [[<C-\>]], "<cmd>1ToggleTerm direction=float<cr>", {
						buffer = term.bufnr,
						desc = "Toggle floating terminal",
					})
				end
				vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
					buffer = term.bufnr,
					desc = "Exit terminal mode",
				})
			end,
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			local cmp = require("cmp")
			cmp.event:on(
				"confirm_done",
				require("nvim-autopairs.completion.cmp").on_confirm_done()
			)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"astro",
			"html",
			"javascript",
			"javascriptreact",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
			"xml",
		},
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
	{
		"mattn/emmet-vim",
		ft = { "css", "html", "javascriptreact", "typescriptreact", "vue" },
	},
}
