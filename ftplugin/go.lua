-- ============================================
-- GO FILETYPE CONFIGURATION - CLEAN VERSION
-- ============================================

-- Check if go.nvim is available
local go_ok, _ = pcall(require, "go")
if not go_ok then
	return
end

-- Go-specific settings
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false

-- Buffer-local keymaps
local opts = { noremap = true, silent = true, buffer = true }

-- ============================================
-- TEST COMMANDS
-- ============================================
vim.keymap.set("n", "<leader>ga", "<cmd>GoAddTest<cr>", opts)
vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", opts)
vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFunc<cr>", opts)
vim.keymap.set("n", "<leader>gf", "<cmd>GoTestFile<cr>", opts)
vim.keymap.set("n", "<leader>gp", "<cmd>GoTestPkg<cr>", opts)
vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", opts)
vim.keymap.set("n", "<leader>gC", "<cmd>GoCoverageClear<cr>", opts)
vim.keymap.set("n", "<leader>gct", "<cmd>GoCoverageToggle<cr>", opts)

-- ============================================
-- CODE ACTIONS
-- ============================================
vim.keymap.set("n", "<leader>gj", "<cmd>GoAddTag json<cr>", opts)
vim.keymap.set("n", "<leader>gy", "<cmd>GoAddTag yaml<cr>", opts)
vim.keymap.set("n", "<leader>gr", "<cmd>GoRmTag<cr>", opts)
vim.keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<cr>", opts)
vim.keymap.set("n", "<leader>gsw", "<cmd>GoFillSwitch<cr>", opts)
vim.keymap.set("n", "<leader>ge", "<cmd>GoIfErr<cr>", opts)

-- ============================================
-- CODE NAVIGATION
-- ============================================
vim.keymap.set("n", "<leader>gA", "<cmd>GoAlt<cr>", opts)
vim.keymap.set("n", "<leader>gAs", "<cmd>GoAlt!<cr>", opts)
vim.keymap.set("n", "<leader>gAv", "<cmd>GoAltV<cr>", opts)
vim.keymap.set("n", "<leader>gi", "<cmd>GoImpl<cr>", opts)
vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", opts)

-- ============================================
-- BUILD & RUN
-- ============================================
vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<cr>", opts)
vim.keymap.set("n", "<leader>gR", "<cmd>GoRun<cr>", opts)
vim.keymap.set("n", "<leader>gdb", "<cmd>GoDebug<cr>", opts)
vim.keymap.set("n", "<leader>gbb", "<cmd>GoBreakToggle<cr>", opts)

-- ============================================
-- DEPENDENCIES
-- ============================================
vim.keymap.set("n", "<leader>gmt", "<cmd>GoModTidy<cr>", opts)
vim.keymap.set("n", "<leader>gmi", "<cmd>GoModInit<cr>", opts)
vim.keymap.set("n", "<leader>gmg", "<cmd>GoGet<cr>", opts)

-- ============================================
-- LINTING & FORMATTING
-- ============================================
vim.keymap.set("n", "<leader>gl", "<cmd>GoLint<cr>", opts)
vim.keymap.set("n", "<leader>gv", "<cmd>GoVet<cr>", opts)
vim.keymap.set("n", "<leader>gF", "<cmd>GoFmt<cr>", opts)
vim.keymap.set("n", "<leader>gI", "<cmd>GoImport<cr>", opts)

-- ============================================
-- STRUCT TAGS VISUAL MODE
-- ============================================
vim.keymap.set("v", "<leader>gj", ":<C-u>GoAddTag json<cr>", opts)
vim.keymap.set("v", "<leader>gy", ":<C-u>GoAddTag yaml<cr>", opts)
vim.keymap.set("v", "<leader>gr", ":<C-u>GoRmTag<cr>", opts)

-- ============================================
-- AUTO COMMANDS
-- ============================================

-- Auto import on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
})

-- Organize imports on save
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
})
