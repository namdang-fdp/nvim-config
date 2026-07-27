local devtools = require("core.devtools")

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local function map(keys, action, desc, mode)
					vim.keymap.set(mode or "n", keys, action, {
						buffer = event.buf,
						desc = "LSP: " .. desc,
					})
				end

				map("gd", function()
					require("telescope.builtin").lsp_definitions()
				end, "Go to definition")
				map("gr", function()
					require("telescope.builtin").lsp_references()
				end, "Go to references")
				map("gI", function()
					require("telescope.builtin").lsp_implementations()
				end, "Go to implementation")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, "Hover documentation")
				map("<leader>ct", function()
					require("telescope.builtin").lsp_type_definitions()
				end, "Type definition")
				map("<leader>cs", function()
					require("telescope.builtin").lsp_document_symbols()
				end, "Document symbols")
				map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })

				for _, client in ipairs(vim.lsp.get_clients({ bufnr = event.buf })) do
					if client.name == "eslint" then
						map("<leader>ce", function()
							vim.lsp.buf.code_action({
								apply = true,
								context = { only = { "source.fixAll.eslint" } },
							})
						end, "ESLint fix all")
						break
					end
				end
			end,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local servers = {
			gopls = {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
						usePlaceholders = true,
						completeUnimported = true,
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
			},
			ts_ls = {},
			eslint = {
				settings = {
					workingDirectory = { mode = "auto" },
					format = false,
				},
			},
			html = {},
			cssls = {},
			tailwindcss = {},
			jsonls = {},
			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			},
		}

		require("mason").setup({
			ui = { border = "rounded" },
		})
		require("mason-tool-installer").setup({
			ensure_installed = devtools.mason_tools,
			run_on_start = false,
			integrations = {
				["mason-lspconfig"] = true,
			},
		})

		for name, config in pairs(servers) do
			config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
			vim.lsp.config(name, config)
		end

		require("mason-lspconfig").setup({
			automatic_enable = {
				"gopls",
				"lua_ls",
				"ts_ls",
				"eslint",
				"html",
				"cssls",
				"tailwindcss",
				"jsonls",
				"pyright",
			},
		})
	end,
}
