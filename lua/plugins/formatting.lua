-- ============================================
-- CODE FORMATTING
-- ============================================

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			-- Go formatting - use goimports only (more stable)
			go = { "goimports" },
			java = { "google-java-format" },
			lua = { "stylua" },
		},
		formatters = {
			["google-java-format"] = {
				prepend_args = { "--aosp" },
			},
		},
		-- Disable format on save for Go (go.nvim handles it)
		format_on_save = function(bufnr)
			-- Disable for Go files (go.nvim handles formatting)
			if vim.bo[bufnr].filetype == "go" then
				return
			end
			return {
				timeout_ms = 3000,
				lsp_fallback = true,
			}
		end,
		-- Suppress notifications
		notify_on_error = false,
	},
}
