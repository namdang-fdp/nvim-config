return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			python = { "ruff" },
		}

		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = group,
			callback = function(args)
				if not vim.b[args.buf].bigfile then
					lint.try_lint()
				end
			end,
		})

		vim.keymap.set("n", "<leader>cl", lint.try_lint, { desc = "Lint buffer" })
	end,
}
