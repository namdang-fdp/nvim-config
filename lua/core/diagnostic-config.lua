local M = {}

M.virtual_text = {
	spacing = 2,
	prefix = "●",
	source = "if_many",
	severity = { min = vim.diagnostic.severity.WARN },
}

vim.diagnostic.config({
	virtual_text = M.virtual_text,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
})

function M.toggle_virtual_text()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({
		virtual_text = current == false and M.virtual_text or false,
	})
	vim.notify(
		"Diagnostic virtual text " .. (current == false and "enabled" or "disabled"),
		vim.log.levels.INFO,
		{ title = "Diagnostics" }
	)
end

return M
