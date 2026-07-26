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
			auto_format = false,
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
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
