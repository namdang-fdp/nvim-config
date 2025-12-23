-- ============================================
-- AUTO COMMANDS
-- ============================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Auto close terminal buffer
vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	command = "close",
})
