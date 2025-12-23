-- ============================================
-- JAVA FILETYPE CONFIGURATION
-- ============================================

-- Check if jdtls is available
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify("nvim-jdtls not installed", vim.log.levels.WARN)
	return
end

-- Lombok path
local lombok_path = vim.fn.expand("~/.local/share/nvim/lombok/lombok.jar")

if vim.fn.filereadable(lombok_path) == 0 then
	vim.notify("Lombok JAR not found at: " .. lombok_path, vim.log.levels.WARN)
	return
end

-- Find JDTLS installation
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

if launcher_jar == "" then
	vim.notify("JDTLS not found. Install it via :Mason", vim.log.levels.ERROR)
	return
end

-- Determine OS-specific config
local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
	os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
	os_config = "config_win"
end

-- Project workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

-- Root directory finder
local function get_root_dir()
	return require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
end

-- JDTLS configuration
local config = {
	cmd = {
		"java",
		"-javaagent:" .. lombok_path,
		"-Xms1g",
		"-Xmx2g",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		launcher_jar,
		"-configuration",
		mason_path .. "/" .. os_config,
		"-data",
		workspace_dir,
	},

	root_dir = get_root_dir(),

	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "automatic",
				runtimes = {},
			},
			maven = {
				downloadSources = true,
				updateSnapshots = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
			},
			autobuild = {
				enabled = true,
			},
			completion = {
				filteredTypes = {
					"java.awt.*",
					"com.sun.*",
					"sun.*",
				},
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			project = {
				referencedLibraries = {
					"lib/**/*.jar",
				},
			},
		},
		signatureHelp = {
			enabled = true,
		},
	},

	init_options = {
		bundles = {},
		extendedClientCapabilities = {
			progressReportProvider = false,
			classFileContentsSupport = true,
			generateToStringPromptSupport = true,
			hashCodeEqualsPromptSupport = true,
			advancedExtractRefactoringSupport = true,
			advancedOrganizeImportsSupport = true,
			generateConstructorsPromptSupport = true,
			generateDelegateMethodsPromptSupport = true,
			moveRefactoringSupport = true,
			overrideMethodsPromptSupport = true,
			inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
		},
	},

	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		-- Java specific commands
		vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
		vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
		vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
		vim.keymap.set("v", "<leader>jm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)

		-- Format on save
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
}

-- Start JDTLS
jdtls.start_or_attach(config)
