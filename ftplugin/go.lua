-- ============================================
-- GO FILETYPE CONFIGURATION
-- ============================================

-- Check if go.nvim is available
local go_ok, go = pcall(require, "go")
if not go_ok then
	vim.notify("go.nvim not installed", vim.log.levels.WARN)
	return
end

-- Go-specific settings
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false -- Go uses tabs

-- Buffer-local keymaps
local opts = { noremap = true, silent = true, buffer = true }

-- ============================================
-- TEST COMMANDS
-- ============================================

-- Add test for current function - Giống trong video
vim.keymap.set("n", "<leader>ga", "<cmd>GoAddTest<cr>", vim.tbl_extend("force", opts, { desc = "Go: Add test" }))

-- Run tests
vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", vim.tbl_extend("force", opts, { desc = "Go: Test" }))
vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFunc<cr>", vim.tbl_extend("force", opts, { desc = "Go: Test function" }))
vim.keymap.set("n", "<leader>gf", "<cmd>GoTestFile<cr>", vim.tbl_extend("force", opts, { desc = "Go: Test file" }))
vim.keymap.set("n", "<leader>gp", "<cmd>GoTestPkg<cr>", vim.tbl_extend("force", opts, { desc = "Go: Test package" }))

-- Test coverage
vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", vim.tbl_extend("force", opts, { desc = "Go: Coverage" }))
vim.keymap.set(
	"n",
	"<leader>gC",
	"<cmd>GoCoverageClear<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Clear coverage" })
)
vim.keymap.set(
	"n",
	"<leader>gct",
	"<cmd>GoCoverageToggle<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Toggle coverage" })
)

-- ============================================
-- CODE ACTIONS
-- ============================================

-- Add tags to struct
vim.keymap.set(
	"n",
	"<leader>gj",
	"<cmd>GoAddTag json<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Add json tags" })
)
vim.keymap.set(
	"n",
	"<leader>gy",
	"<cmd>GoAddTag yaml<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Add yaml tags" })
)
vim.keymap.set("n", "<leader>gr", "<cmd>GoRmTag<cr>", vim.tbl_extend("force", opts, { desc = "Go: Remove tags" }))

-- Fill struct
vim.keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<cr>", vim.tbl_extend("force", opts, { desc = "Go: Fill struct" }))

-- Fill switch
vim.keymap.set("n", "<leader>gsw", "<cmd>GoFillSwitch<cr>", vim.tbl_extend("force", opts, { desc = "Go: Fill switch" }))

-- If err != nil
vim.keymap.set("n", "<leader>ge", "<cmd>GoIfErr<cr>", vim.tbl_extend("force", opts, { desc = "Go: Add if err" }))

-- ============================================
-- CODE NAVIGATION & INFO
-- ============================================

-- Alternate between test and implementation
vim.keymap.set(
	"n",
	"<leader>gA",
	"<cmd>GoAlt<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Alternate file (test/impl)" })
)
vim.keymap.set("n", "<leader>gAs", "<cmd>GoAlt!<cr>", vim.tbl_extend("force", opts, { desc = "Go: Alternate split" }))
vim.keymap.set("n", "<leader>gAv", "<cmd>GoAltV<cr>", vim.tbl_extend("force", opts, { desc = "Go: Alternate vsplit" }))

-- Implementation/Interface
vim.keymap.set(
	"n",
	"<leader>gi",
	"<cmd>GoImpl<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Implement interface" })
)

-- Doc
vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", vim.tbl_extend("force", opts, { desc = "Go: Show doc" }))

-- Callees/Callers
vim.keymap.set("n", "<leader>gce", "<cmd>GoCallees<cr>", vim.tbl_extend("force", opts, { desc = "Go: Callees" }))
vim.keymap.set("n", "<leader>gcr", "<cmd>GoCallers<cr>", vim.tbl_extend("force", opts, { desc = "Go: Callers" }))

-- Guru (code navigation)
vim.keymap.set("n", "<leader>grs", "<cmd>GoReferrers<cr>", vim.tbl_extend("force", opts, { desc = "Go: Referrers" }))
vim.keymap.set(
	"n",
	"<leader>gch",
	"<cmd>GoChannelPeers<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Channel peers" })
)

-- ============================================
-- BUILD & RUN
-- ============================================

-- Build
vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<cr>", vim.tbl_extend("force", opts, { desc = "Go: Build" }))

-- Run
vim.keymap.set("n", "<leader>gR", "<cmd>GoRun<cr>", vim.tbl_extend("force", opts, { desc = "Go: Run" }))

-- Debug
vim.keymap.set("n", "<leader>gdb", "<cmd>GoDebug<cr>", vim.tbl_extend("force", opts, { desc = "Go: Debug" }))
vim.keymap.set("n", "<leader>gds", "<cmd>GoDebug -s<cr>", vim.tbl_extend("force", opts, { desc = "Go: Debug stop" }))
vim.keymap.set("n", "<leader>gdt", "<cmd>GoDebug -t<cr>", vim.tbl_extend("force", opts, { desc = "Go: Debug test" }))
vim.keymap.set("n", "<leader>gdn", "<cmd>GoDebug -n<cr>", vim.tbl_extend("force", opts, { desc = "Go: Debug nearest" }))

-- Breakpoint
vim.keymap.set(
	"n",
	"<leader>gbb",
	"<cmd>GoBreakToggle<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Toggle breakpoint" })
)

-- ============================================
-- DEPENDENCIES
-- ============================================

-- Mod tidy
vim.keymap.set("n", "<leader>gmt", "<cmd>GoModTidy<cr>", vim.tbl_extend("force", opts, { desc = "Go: Mod tidy" }))

-- Mod init
vim.keymap.set("n", "<leader>gmi", "<cmd>GoModInit<cr>", vim.tbl_extend("force", opts, { desc = "Go: Mod init" }))

-- Get dependencies
vim.keymap.set("n", "<leader>gmg", "<cmd>GoGet<cr>", vim.tbl_extend("force", opts, { desc = "Go: Get package" }))

-- ============================================
-- CODE GENERATION
-- ============================================

-- Generate code
vim.keymap.set("n", "<leader>gg", "<cmd>GoGenerate<cr>", vim.tbl_extend("force", opts, { desc = "Go: Generate" }))

-- Mock
vim.keymap.set("n", "<leader>gmo", "<cmd>GoMockGen<cr>", vim.tbl_extend("force", opts, { desc = "Go: Generate mock" }))

-- ============================================
-- LINTING & FORMATTING
-- ============================================

-- Lint
vim.keymap.set("n", "<leader>gl", "<cmd>GoLint<cr>", vim.tbl_extend("force", opts, { desc = "Go: Lint" }))

-- Vet
vim.keymap.set("n", "<leader>gv", "<cmd>GoVet<cr>", vim.tbl_extend("force", opts, { desc = "Go: Vet" }))

-- Format
vim.keymap.set("n", "<leader>gF", "<cmd>GoFmt<cr>", vim.tbl_extend("force", opts, { desc = "Go: Format" }))

-- Imports
vim.keymap.set("n", "<leader>gI", "<cmd>GoImport<cr>", vim.tbl_extend("force", opts, { desc = "Go: Add import" }))
vim.keymap.set("n", "<leader>gId", "<cmd>GoDrop<cr>", vim.tbl_extend("force", opts, { desc = "Go: Drop import" }))

-- ============================================
-- COMMENTS
-- ============================================

-- Add comment
vim.keymap.set("n", "<leader>gca", "<cmd>GoCmt<cr>", vim.tbl_extend("force", opts, { desc = "Go: Add comment" }))

-- ============================================
-- PLAYGROUND
-- ============================================

-- Run in Go Playground
vim.keymap.set("n", "<leader>gpl", "<cmd>GoPlay<cr>", vim.tbl_extend("force", opts, { desc = "Go: Run in playground" }))

-- ============================================
-- RENAME
-- ============================================

-- Rename (using gorename)
vim.keymap.set("n", "<leader>gn", "<cmd>GoRename<cr>", vim.tbl_extend("force", opts, { desc = "Go: Rename" }))

-- ============================================
-- STRUCT TAGS VISUAL MODE
-- ============================================

-- Add tags in visual mode
vim.keymap.set(
	"v",
	"<leader>gj",
	":<C-u>GoAddTag json<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Add json tags" })
)
vim.keymap.set(
	"v",
	"<leader>gy",
	":<C-u>GoAddTag yaml<cr>",
	vim.tbl_extend("force", opts, { desc = "Go: Add yaml tags" })
)
vim.keymap.set("v", "<leader>gr", ":<C-u>GoRmTag<cr>", vim.tbl_extend("force", opts, { desc = "Go: Remove tags" }))

-- ============================================
-- AUTO COMMANDS
-- ============================================

-- Auto import on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		-- Organize imports
		require("go.format").goimport()
	end,
})

-- Run gofmt + goimports on save (already handled by conform.nvim but this is backup)
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

-- Highlight on yank for Go files
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*.go",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- ============================================
-- WHICH-KEY INTEGRATION (Optional but recommended)
-- ============================================

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
	wk.register({
		g = {
			name = "Go",
			a = "Add test",
			A = {
				name = "Alternate",
				_ = "Switch test/impl",
				s = "Split",
				v = "Vsplit",
			},
			b = "Build",
			B = "Breakpoint toggle",
			c = {
				name = "Coverage/Calls",
				_ = "Coverage",
				t = "Toggle coverage",
				e = "Callees",
				r = "Callers",
				a = "Add comment",
				h = "Channel peers",
			},
			C = "Clear coverage",
			d = {
				name = "Debug/Doc",
				_ = "Doc",
				b = "Debug",
				s = "Debug stop",
				t = "Debug test",
				n = "Debug nearest",
			},
			e = "If err",
			f = {
				name = "Fill",
				s = "Fill struct",
			},
			F = "Format",
			g = "Generate",
			i = "Implement interface",
			I = {
				name = "Import",
				_ = "Add import",
				d = "Drop import",
			},
			j = "Add json tags",
			l = "Lint",
			m = {
				name = "Mod/Mock",
				t = "Mod tidy",
				i = "Mod init",
				g = "Get package",
				o = "Generate mock",
			},
			n = "Rename",
			p = "Test package",
			pl = "Playground",
			r = {
				name = "Remove/Referrers",
				_ = "Remove tags",
				s = "Referrers",
			},
			R = "Run",
			s = {
				name = "Switch",
				w = "Fill switch",
			},
			t = "Test",
			T = "Test function",
			v = "Vet",
			y = "Add yaml tags",
		},
	}, {
		mode = "n",
		prefix = "<leader>",
		buffer = vim.api.nvim_get_current_buf(),
	})
end

-- ============================================
-- NOTIFICATIONS
-- ============================================

vim.notify("Go development mode activated! 🚀", vim.log.levels.INFO, {
	title = "Go",
})
