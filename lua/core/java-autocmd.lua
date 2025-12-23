-- ============================================
-- JAVA AUTO COMMANDS - ENHANCED DIAGNOSTICS
-- ============================================
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		-- Set diagnostic signs
		local signs = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		}
		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

		-- Check JDTLS running after delay
		vim.defer_fn(function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local jdtls_running = false

			for _, client in ipairs(clients) do
				if client.name == "jdtls" then
					jdtls_running = true
					vim.notify("JDTLS is running!", vim.log.levels.INFO)
					break
				end
			end

			if not jdtls_running then
				vim.notify("JDTLS not started! Check :LspInfo", vim.log.levels.WARN)
			end
		end, 5000)
	end,
})
