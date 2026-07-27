local function map(keys, action, desc)
	vim.keymap.set("n", keys, action, {
		buffer = true,
		silent = true,
		desc = "Python: " .. desc,
	})
end

map("<leader>lpf", function()
	require("conform").format({ async = true, formatters = { "ruff_format" } })
end, "Format with Ruff")

map("<leader>lpl", function()
	require("lint").try_lint()
end, "Lint with Ruff")
