-- ============================================
-- LSP CONFIGURATION
-- ============================================

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		-- LSP Attach keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
				map("gr", require("telescope.builtin").lsp_references, "Goto References")
				map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")
			end,
		})

		-- Capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Server configurations
		local servers = {
			-- Go
			gopls = {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
					},
				},
			},
			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			},
			-- TypeScript/JavaScript
			ts_ls = {},
			-- HTML
			html = {},
			-- CSS
			cssls = {},
			-- Tailwind
			tailwindcss = {},
			-- JSON
			jsonls = {},
			-- Java - KHÔNG DÙNG CONFIG NÀY, dùng ftplugin/java.lua
			-- jdtls = { ... },  -- ← XÓA HOẶC COMMENT toàn bộ phần này
		}

		-- Mason setup
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Go
				"gopls",
				"goimports",
				"gofumpt",
				"golangci-lint",
				-- Lua
				"lua_ls",
				"stylua",
				-- TypeScript/JavaScript
				"typescript-language-server",
				"prettier",
				"eslint_d",
				-- HTML/CSS
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				-- JSON
				"json-lsp",
				-- Java
				"jdtls",
				"google-java-format",
			},
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					if server_name == "jdtls" then
						return
					end

					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
