return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical terminal" },
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
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "rounded",
				winblend = 0,
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
				desc = "Exit terminal mode",
			})
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
