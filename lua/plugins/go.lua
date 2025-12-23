-- ============================================
-- GO DEVELOPMENT - CLEAN VERSION
-- ============================================

return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			-- Disable all notifications and prompts
			notify = false,
			auto_format = true,
			auto_lint = false,

			-- Format settings
			gofmt = "gofumpt",
			max_line_len = 120,
			tag_transform = false,
			tag_options = "json=omitempty",

			-- LSP settings
			lsp_cfg = false,
			lsp_gofumpt = true,
			lsp_on_attach = nil,
			lsp_keymaps = false,
			lsp_codelens = true,
			lsp_diag_hdlr = true,
			lsp_inlay_hints = {
				enable = true,
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = " ",
				other_hints_prefix = "=> ",
			},

			-- Test settings
			test_runner = "go",
			run_in_floaterm = false,

			-- Disable verbose output
			verbose = false,

			-- Disable trouble integration
			trouble = false,
			luasnip = true,
		})

		-- Auto format on save (silent)
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})

		-- Auto organize imports on save (silent)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				local params = vim.lsp.util.make_range_params()
				params.context = { only = { "source.organizeImports" } }
				local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
				for _, res in pairs(result or {}) do
					for _, r in pairs(res.result or {}) do
						if r.edit then
							vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
						else
							vim.lsp.buf.execute_command(r.command)
						end
					end
				end
			end,
			group = format_sync_grp,
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
