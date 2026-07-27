local ok, jdtls = pcall(require, "jdtls")
if not ok then
	vim.notify("nvim-jdtls is unavailable", vim.log.levels.ERROR, { title = "Java" })
	return
end

local bufnr = vim.api.nvim_get_current_buf()
local root_dir = vim.fs.root(bufnr, {
	"mvnw",
	"gradlew",
	"pom.xml",
	"build.gradle",
	"build.gradle.kts",
	"settings.gradle",
	"settings.gradle.kts",
	".git",
})

if not root_dir then
	vim.notify("No Maven, Gradle, or Git project root found", vim.log.levels.WARN, { title = "Java" })
	return
end

local java_bin = vim.fn.exepath("java")
if java_bin == "" then
	vim.notify(
		"Java is not on PATH; install a system Java 21 runtime to start JDTLS",
		vim.log.levels.ERROR,
		{ title = "Java" }
	)
	return
end

local mason_package = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_package .. "/plugins/org.eclipse.equinox.launcher_*.jar", false, true)[1]
if not launcher_jar then
	vim.notify("JDTLS is not installed; run :DevToolsSync", vim.log.levels.ERROR, { title = "Java" })
	return
end

local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
	os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
	os_config = "config_win"
end

local workspace_id = vim.fn.fnamemodify(root_dir, ":t") .. "-" .. vim.fn.sha256(root_dir):sub(1, 10)
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. workspace_id

local lombok_jar = vim.fn.expand("~/.local/share/nvim/lombok/lombok.jar")
local has_lombok = vim.fn.filereadable(lombok_jar) == 1
if not has_lombok then
	vim.notify(
		"Lombok agent is not readable at " .. lombok_jar .. "; starting JDTLS without Lombok support",
		vim.log.levels.WARN,
		{ title = "Java" }
	)
end

local cmd = {
	java_bin,
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=WARN",
	"-Xms512m",
	"-Xmx2g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
}

if has_lombok then
	table.insert(cmd, "-javaagent:" .. lombok_jar)
end

vim.list_extend(cmd, {
	"-jar",
	launcher_jar,
	"-configuration",
	mason_package .. "/" .. os_config,
	"-data",
	workspace_dir,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end

local function map(keys, action, desc)
	vim.keymap.set("n", keys, action, {
		buffer = bufnr,
		silent = true,
		desc = "Java: " .. desc,
	})
end

local config = {
	cmd = cmd,
	root_dir = root_dir,
	capabilities = capabilities,
	settings = {
		java = {
			-- Do not force Eclipse APT globally. Maven/Gradle project metadata owns
			-- annotation-processor configuration; Lombok support is an optional agent.
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			configuration = { updateBuildConfiguration = "interactive" },
			autobuild = { enabled = true },
			errors = { incompleteClasspath = { severity = "warning" } },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
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
	on_attach = function()
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		map("<leader>ljo", jdtls.organize_imports, "Organize imports")
		map("<leader>ljr", "<cmd>JdtlsRestart<cr>", "Restart JDTLS")
	end,
}

vim.api.nvim_buf_create_user_command(bufnr, "JdtlsRestart", function(opts)
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, name = "jdtls" })) do
		client:stop(true)
	end

	if opts.bang then
		vim.fn.delete(workspace_dir, "rf")
	end

	vim.defer_fn(function()
		if vim.api.nvim_buf_is_valid(bufnr) then
			jdtls.start_or_attach(config)
		end
	end, 200)
end, {
	bang = true,
	desc = "Restart JDTLS; add ! to clear this project's workspace",
})

jdtls.start_or_attach(config)
