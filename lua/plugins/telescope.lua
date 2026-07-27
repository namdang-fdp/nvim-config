return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				border = true,
				borderchars = {
					prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
				file_ignore_patterns = {
					"node_modules/",
					".git/",
					"target/classes/",
					"build/classes/",
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						prompt_position = "top",
					},
					width = 0.87,
					height = 0.80,
				},
				sorting_strategy = "ascending",
				prompt_prefix = "  ",
				selection_caret = " ",
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-d>"] = actions.delete_buffer,
						["<C-u>"] = false,
					},
					n = {
						["q"] = actions.close,
						["<C-d>"] = actions.delete_buffer,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
					"--glob=!target/classes/",
					"--glob=!build/classes/",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				buffers = {
					sort_lastused = true,
					sort_mru = true,
					ignore_current_buffer = true,
				},
				oldfiles = {
					only_cwd = true,
				},
			},
		})

		if vim.fn.executable("make") == 1 then
			local loaded, load_error = pcall(telescope.load_extension, "fzf")
			if not loaded then
				vim.notify("Telescope FZF is unavailable: " .. tostring(load_error), vim.log.levels.WARN)
			end
		else
			vim.notify_once("make is unavailable; Telescope is using its built-in sorter", vim.log.levels.INFO)
		end

		local function needs(executable, callback)
			return function()
				if vim.fn.executable(executable) ~= 1 then
					vim.notify(executable .. " is required for this search", vim.log.levels.WARN, { title = "Telescope" })
					return
				end
				callback()
			end
		end

		local maps = {
			{ "<leader>ff", builtin.find_files, "Find files" },
			{ "<leader>fa", function() builtin.find_files({ hidden = true, no_ignore = true }) end, "Find all files" },
			{ "<leader>fr", builtin.oldfiles, "Recent files" },
			{ "<leader>fg", needs("rg", builtin.live_grep), "Grep project" },
			{ "<leader>fw", needs("rg", builtin.grep_string), "Grep word" },
			{ "<leader>fb", builtin.buffers, "Find buffers" },
			{ "<leader>fs", builtin.lsp_document_symbols, "Document symbols" },
			{ "<leader>fS", builtin.lsp_workspace_symbols, "Workspace symbols" },
			{ "<leader>fh", builtin.help_tags, "Help tags" },
			{ "<leader>fk", builtin.keymaps, "Keymaps" },
			{ "<leader>fc", builtin.commands, "Commands" },
			{ "<leader>f/", builtin.current_buffer_fuzzy_find, "Search current buffer" },
			{ "<leader>f.", builtin.resume, "Resume search" },
			{ "<leader>bb", builtin.buffers, "Buffer picker" },
			{ "<leader>gB", builtin.git_branches, "Git branches" },
			{ "<leader>gc", builtin.git_commits, "Git commits" },
			{ "<leader>gS", builtin.git_status, "Git status" },
			{ "<leader>xD", builtin.diagnostics, "Search diagnostics" },
		}

		for _, map in ipairs(maps) do
			vim.keymap.set("n", map[1], map[2], { desc = map[3], silent = true })
		end
	end,
}
