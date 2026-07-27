return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "┆" },
		},
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 500,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> — <summary>",
		max_file_length = 20000,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, keys, action, desc, extra)
				vim.keymap.set(mode, keys, action, vim.tbl_extend("force", {
					buffer = bufnr,
					desc = "Git: " .. desc,
				}, extra or {}))
			end

			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(gs.next_hunk)
				return "<Ignore>"
			end, "Next hunk", { expr = true })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(gs.prev_hunk)
				return "<Ignore>"
			end, "Previous hunk", { expr = true })

			map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>ghs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk")
			map("v", "<leader>ghr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk")
			map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo staged hunk")
			map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
			map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>ghb", function()
				gs.blame_line({ full = true })
			end, "Blame line")
			map("n", "<leader>ghd", gs.diffthis, "Diff this")
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", "Select hunk")

			map("n", "<leader>ub", function()
				gs.toggle_current_line_blame()
			end, "Toggle Git blame")
		end,
	},
}
