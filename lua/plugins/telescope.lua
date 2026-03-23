-- ============================================
-- TELESCOPE - FIXED FOR MODULAR MONOLITH
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
				-- CRITICAL: Don't ignore these patterns for modular monolith
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"target/classes", -- Ignore compiled classes only
					"build/classes",
				},
				layout_config = {
					horizontal = {
						preview_width = 0.55,
					},
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
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
					"--hidden", -- Search hidden files
					"--glob=!.git/", -- But ignore .git
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					-- CRITICAL: Search from project root, not cwd
					cwd = vim.fn.getcwd(),
					-- Follow symlinks
					follow = true,
					-- Don't respect gitignore for Java modules
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
					-- CRITICAL: Search all subdirectories
					cwd = vim.fn.getcwd(),
				},
			},
		})

		pcall(telescope.load_extension, "fzf")

		local builtin = require("telescope.builtin")

		-- FIXED: Search all files in project
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				cwd = vim.fn.getcwd(),
				hidden = true,
				no_ignore = false,
			})
		end, { desc = "Find files" })

		-- FIXED: Grep all files in project
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({
				cwd = vim.fn.getcwd(),
				additional_args = { "--hidden" },
			})
		end, { desc = "Grep text (tìm kiếm nội dung)" })

		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
	end,
}
