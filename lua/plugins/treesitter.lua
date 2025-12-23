-- ============================================
-- TREESITTER - SYNTAX HIGHLIGHTING
-- ============================================

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- Go
				"go",
				"gomod",
				"gosum",
				-- Java
				"java",
				-- Frontend
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"tsx",
				"vue",
				"svelte",
				"astro",
				-- Config
				"json",
				"yaml",
				"toml",
				-- Lua/Vim
				"lua",
				"vim",
				"vimdoc",
				-- Other
				"markdown",
				"markdown_inline",
				"bash",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
