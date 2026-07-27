local M = {}

M.mason_tools = {
	-- Frontend
	"typescript-language-server",
	"eslint-lsp",
	"tailwindcss-language-server",
	"html-lsp",
	"css-lsp",
	"json-lsp",
	"prettier",

	-- Go
	"gopls",
	"delve",
	"goimports",
	"gofumpt",
	"golangci-lint",

	-- Java
	"jdtls",
	"google-java-format",

	-- Python
	"pyright",
	"ruff",

	-- Lua
	"lua-language-server",
	"stylua",

	-- Lightweight support
	"clang-format",
	"shfmt",
	"sql-formatter",
}

M.treesitter_parsers = {
	"astro",
	"bash",
	"c",
	"c_sharp",
	"cmake",
	"cpp",
	"css",
	"cuda",
	"dart",
	"dockerfile",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"html",
	"java",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"scss",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"yaml",
}

vim.api.nvim_create_user_command("DevToolsSync", function()
	local ok, lazy = pcall(require, "lazy")
	if not ok then
		vim.notify("lazy.nvim is not available", vim.log.levels.ERROR, { title = "DevToolsSync" })
		return
	end

	lazy.load({ plugins = { "nvim-lspconfig", "nvim-treesitter" } })
	vim.schedule(function()
		if vim.fn.exists(":MasonToolsInstall") == 2 then
			vim.cmd("MasonToolsInstall")
		else
			vim.notify("MasonToolsInstall is unavailable", vim.log.levels.ERROR, { title = "DevToolsSync" })
		end

		if vim.fn.exists(":TSInstall") == 2 then
			vim.cmd("TSInstall " .. table.concat(M.treesitter_parsers, " "))
		else
			vim.notify("TSInstall is unavailable", vim.log.levels.WARN, { title = "DevToolsSync" })
		end
	end)
end, {
	desc = "Install approved Mason tools and missing Treesitter parsers",
})

return M
