-- ============================================
-- GO DEVELOPMENT - ENHANCED
-- ============================================

return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua", -- UI library
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			-- ============================================
			-- GENERAL SETTINGS
			-- ============================================
			go = "go", -- Go binary path
			goimports = "gopls", -- goimports command
			fillstruct = "gopls", -- fillstruct command
			gofmt = "gofumpt", -- gofmt cmd (gofumpt is faster)
			max_line_len = 120, -- max line length in gofmt

			-- ============================================
			-- TAG SETTINGS
			-- ============================================
			tag_transform = false, -- don't transform tags (keep original case)
			tag_options = "json=omitempty", -- default tag options
			gotests_template = "", -- use default gotests template
			gotests_template_dir = "", -- gotests template directory

			-- ============================================
			-- COMMENT SETTINGS
			-- ============================================
			comment_placeholder = "   ", -- comment placeholder

			-- ============================================
			-- LSP SETTINGS
			-- ============================================
			lsp_cfg = false, -- use default LSP config (we already configured in lsp.lua)
			lsp_gofumpt = true, -- use gofumpt in LSP
			lsp_on_attach = nil, -- use default on_attach (from lsp.lua)
			lsp_keymaps = false, -- don't set LSP keymaps (we handle in lsp.lua)
			lsp_codelens = true, -- enable codelens
			lsp_diag_hdlr = true, -- use go.nvim diagnostic handler
			lsp_diag_virtual_text = { space = 0, prefix = "■" }, -- virtual text prefix
			lsp_diag_signs = true,
			lsp_diag_update_in_insert = false,
			lsp_document_formatting = true,
			lsp_inlay_hints = {
				enable = true,
				-- hints style
				only_current_line = false,
				only_current_line_autocmd = "CursorHold",
				show_variable_name = true,
				parameter_hints_prefix = " ",
				show_parameter_hints = true,
				other_hints_prefix = "=> ",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 6,
				highlight = "Comment",
			},

			-- ============================================
			-- DIAGNOSTIC ICONS
			-- ============================================
			lsp_diag_icons = {
				error = "✘",
				warning = "",
				info = "",
				hint = "",
			},

			-- ============================================
			-- GOPLS SETTINGS
			-- ============================================
			gopls_cmd = nil, -- use default gopls
			gopls_remote_auto = true, -- enable gopls remote auto
			gocoverage_sign = "█",
			gocoverage_sign_priority = 5,

			-- ============================================
			-- DAP (DEBUG ADAPTER) SETTINGS
			-- ============================================
			dap_debug = true, -- enable dap
			dap_debug_keymap = true, -- set dap keymaps
			dap_debug_gui = {}, -- use default debug GUI
			dap_debug_vt = { enabled_commands = true, all_frames = true }, -- virtual text for debugging
			dap_port = 38697, -- delve debug port
			dap_timeout = 15, -- see dap option initialize_timeout_sec

			-- ============================================
			-- TEST SETTINGS
			-- ============================================
			test_runner = "go", -- test runner: go, richgo, gotestsum, ginkgo
			run_in_floaterm = false, -- run tests in floating terminal
			test_efm = false, -- errorformat for quickfix
			test_popup = true, -- show test results in popup
			test_popup_auto = false, -- auto show popup
			test_popup_width = 80,
			test_popup_height = 10,
			test_open_cmd = "edit", -- command to open test file

			-- ============================================
			-- BUILD SETTINGS
			-- ============================================
			build_tags = "", -- build tags
			job_timeout = 5000, -- job timeout in milliseconds
			skip_nil_check = false, -- skip nil check

			-- ============================================
			-- UI SETTINGS
			-- ============================================
			floaterm = {
				posititon = "auto", -- auto, top, bottom, left, right, center
				width = 0.45,
				height = 0.98,
			},

			trouble = false, -- use trouble.nvim for diagnostics
			luasnip = true, -- enable luasnip integration

			-- ============================================
			-- ICONS
			-- ============================================
			icons = {
				breakpoint = "🔴",
				currentpos = "🔵",
			},

			-- ============================================
			-- VERBOSE OUTPUT
			-- ============================================
			verbose = false, -- output verbose log

			-- ============================================
			-- NULL-LS INTEGRATION
			-- ============================================
			null_ls = {
				golangci_lint = {
					enable = false, -- use golangci-lint (we use it via mason)
				},
			},
		})

		-- ============================================
		-- AUTO COMMANDS
		-- ============================================

		-- Run gofmt + goimport on save
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})

		-- Auto import on save
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
	build = ':lua require("go.install").update_all_sync()', -- update all tools on install
}
