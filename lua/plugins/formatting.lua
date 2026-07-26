-- ============================================
-- CODE FORMATTING
-- ============================================

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>F",
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
			-- Go formatting - imports first, then stricter gofumpt formatting.
			go = { "goimports", "gofumpt" },
			java = { "google-java-format" },
			lua = { "stylua" },
			-- C/C++
			cpp = { "clang_format" },
			c = { "clang_format" },
		},
		formatters = {
			["google-java-format"] = {
				prepend_args = { "--aosp" },
			},
		},
		format_on_save = function()
			return {
				timeout_ms = 3000,
				lsp_fallback = true,
			}
		end,
		-- Suppress notifications
		notify_on_error = false,
	},
}
