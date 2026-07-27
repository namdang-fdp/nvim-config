vim.g.format_on_save_enabled = vim.g.format_on_save_enabled ~= false

local function toggle_format_on_save()
	vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
	vim.notify(
		"Format on save " .. (vim.g.format_on_save_enabled and "enabled" or "disabled"),
		vim.log.levels.INFO,
		{ title = "Formatting" }
	)
end

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback", timeout_ms = 3000 })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
		{
			"<leader>uf",
			toggle_format_on_save,
			desc = "Toggle format on save",
		},
	},
	init = function()
		vim.api.nvim_create_user_command("FormatToggle", toggle_format_on_save, {
			desc = "Toggle global format on save",
		})
	end,
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
			["yaml.docker-compose"] = { "prettier" },
			markdown = { "prettier" },
			go = { "goimports", "gofumpt" },
			java = { "google-java-format" },
			python = { "ruff_format" },
			lua = { "stylua" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			sql = { "sql_formatter" },
			dart = { "dart_format" },
		},
		formatters = {
			["google-java-format"] = {
				prepend_args = { "--aosp" },
			},
		},
		format_on_save = function(bufnr)
			if
				not vim.g.format_on_save_enabled
				or vim.b[bufnr].format_on_save == false
				or vim.b[bufnr].bigfile
			then
				return
			end
			return {
				timeout_ms = 3000,
				lsp_format = "fallback",
			}
		end,
		notify_on_error = true,
		notify_no_formatters = false,
	},
}
