return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	config = function()
		vim.treesitter.language.register("bash", "zsh")

		require("nvim-treesitter.configs").setup({
			-- Parser installation is explicit via :DevToolsSync.
			ensure_installed = {},
			auto_install = false,
			highlight = {
				enable = true,
				disable = function(_, bufnr)
					return vim.b[bufnr].bigfile == true
				end,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				disable = function(_, bufnr)
					return vim.b[bufnr].bigfile == true
				end,
			},
		})
	end,
}
