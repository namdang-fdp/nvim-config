-- ============================================
-- JAVA CONFIGURATION - JDTLS + LOMBOK (STABLE MODE)
-- Fix: Crash during "Publish Diagnostics" with APT enabled
-- Strategy: Keep Lombok via -javaagent, disable Eclipse APT to prevent crash
-- ============================================

local ok, jdtls = pcall(require, "jdtls")
if not ok then
	vim.notify("nvim-jdtls not found!", vim.log.levels.ERROR)
	return
end

-- Paths
local lombok_path = vim.fn.expand("~/.local/share/nvim/lombok/lombok.jar")
if vim.fn.filereadable(lombok_path) == 0 then
	vim.notify("Lombok not found at " .. lombok_path, vim.log.levels.WARN)
	return
end

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher_jar == "" then
	vim.notify("JDTLS launcher not found in mason path", vim.log.levels.ERROR)
	return
end

local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
	os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
	os_config = "config_win"
end

-- Root + Workspace
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if not root_dir then
	vim.notify("No Maven/Gradle project found for JDTLS", vim.log.levels.WARN)
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

-- Capabilities (nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Diagnostics baseline
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Force JDK java (SDKMAN current)
local java_bin = vim.fn.expand("~/.sdkman/candidates/java/current/bin/java")
if vim.fn.executable(java_bin) == 0 then
	java_bin = "java"
end

local config = {
	cmd = {
		java_bin,

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",

		"-Dlog.protocol=true",
		"-Dlog.level=INFO",

		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- Lombok support (agent only)
		"-javaagent:" .. lombok_path,

		-- ✅ CRITICAL: disable Eclipse APT to prevent AbstractProcessor crash
		"-Dorg.eclipse.jdt.apt.aptEnabled=false",

		"-Xms1g",
		"-Xmx2g",

		"-jar",
		launcher_jar,
		"-configuration",
		mason_path .. "/" .. os_config,
		"-data",
		workspace_dir,
	},

	root_dir = root_dir,
	capabilities = capabilities,

	settings = {
		java = {
			-- ✅ keep APT off in settings too
			apt = { aptEnabled = false },

			eclipse = { downloadSources = true },
			maven = { downloadSources = true, updateSnapshots = true },
			configuration = { updateBuildConfiguration = "interactive" },
			autobuild = { enabled = true },

			errors = { incompleteClasspath = { severity = "warning" } },

			completion = {
				enabled = true,
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
				},
			},

			sources = {
				organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
			},

			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			signatureHelp = { enabled = true },
		},
	},

	init_options = {
		bundles = {},
		extendedClientCapabilities = {
			classFileContentsSupport = true,
			advancedExtractRefactoringSupport = true,
			advancedOrganizeImportsSupport = true,
			overrideMethodsPromptSupport = true,
		},
	},

	on_attach = function(_, bufnr)
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = bufnr, silent = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)
	end,
}

-- Restart helper (no deprecated API)
vim.api.nvim_create_user_command("JdtlsRestart", function(opts)
	if opts.args == "wipe" then
		vim.notify("Wiping JDTLS workspace: " .. workspace_dir, vim.log.levels.WARN)
		vim.fn.delete(workspace_dir, "rf")
	end

	local clients = vim.lsp.get_clients({ name = "jdtls" })
	for _, c in ipairs(clients) do
		c.stop(true)
	end

	vim.defer_fn(function()
		jdtls.start_or_attach(config)
		vim.notify("JDTLS restarted (stable mode: APT OFF)", vim.log.levels.INFO)
	end, 200)
end, {
	nargs = "?",
	complete = function()
		return { "wipe" }
	end,
})

jdtls.start_or_attach(config)
