-- ============================================
-- TELESCOPE - ENHANCED FOR BETTER DX
-- ============================================
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				-- File ignore patterns
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"target/classes",
					"build/classes",
				},

				-- Better layout
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						prompt_position = "top",
					},
					width = 0.87,
					height = 0.80,
				},
				sorting_strategy = "ascending",

				-- Better prompts
				prompt_prefix = "🔍 ",
				selection_caret = "➜ ",
				path_display = { "truncate" },

				-- Mappings
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-d>"] = actions.delete_buffer, -- Delete buffer in buffer picker
						["<C-u>"] = false, -- Disable default clear prompt
					},
					n = {
						["q"] = actions.close,
						["<C-d>"] = actions.delete_buffer,
					},
				},

				-- Ripgrep arguments
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
					follow = true,
					no_ignore = false,
					no_ignore_parent = false,
				},

				live_grep = {
					additional_args = function()
						return {
							"--hidden",
							"--glob=!.git/",
							"--glob=!target/classes/",
							"--glob=!build/classes/",
						}
					end,
				},

				buffers = {
					sort_lastused = true,
					sort_mru = true,
					ignore_current_buffer = true,
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						n = {
							["<c-d>"] = actions.delete_buffer,
							["dd"] = actions.delete_buffer,
						},
					},
				},

				oldfiles = {
					only_cwd = true, -- Chỉ show recent files trong project hiện tại
				},
			},
		})

		-- Load extensions
		pcall(telescope.load_extension, "fzf")

		local builtin = require("telescope.builtin")

		-- ==================== FILE NAVIGATION ====================

		-- Find files
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				no_ignore = false,
			})
		end, { desc = "Find files" })

		-- Find ALL files (including gitignored)
		vim.keymap.set("n", "<leader>fF", function()
			builtin.find_files({
				hidden = true,
				no_ignore = true,
			})
		end, { desc = "Find ALL files (no ignore)" })

		-- Recent files
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })

		-- ==================== SEARCH ====================

		-- Live grep
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({
				additional_args = { "--hidden" },
			})
		end, { desc = "Live grep" })

		-- Grep word under cursor
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })

		-- ==================== BUFFERS ====================

		-- Buffer picker (enhanced)
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffer picker" })

		-- ==================== GIT ====================

		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })

		-- ==================== LSP ====================

		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
		vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })

		-- ==================== HELP ====================

		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })

		-- ==================== EXTRAS ====================

		-- Find in current buffer
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })

		-- Resume last picker
		vim.keymap.set("n", "<leader>f.", builtin.resume, { desc = "Resume last picker" })
	end,
}
