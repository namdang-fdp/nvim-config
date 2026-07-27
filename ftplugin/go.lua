local ok = pcall(require, "go")
if not ok then
	return
end

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false

local function map(mode, keys, action, desc)
	vim.keymap.set(mode, keys, action, {
		buffer = true,
		silent = true,
		desc = "Go: " .. desc,
	})
end

-- Tests and coverage
map("n", "<leader>lga", "<cmd>GoAddTest<cr>", "Add test")
map("n", "<leader>lgt", "<cmd>GoTest<cr>", "Test package")
map("n", "<leader>lgT", "<cmd>GoTestFunc<cr>", "Test function")
map("n", "<leader>lgf", "<cmd>GoTestFile<cr>", "Test file")
map("n", "<leader>lgp", "<cmd>GoTestPkg<cr>", "Test package")
map("n", "<leader>lgc", "<cmd>GoCoverage<cr>", "Coverage")
map("n", "<leader>lgC", "<cmd>GoCoverageClear<cr>", "Clear coverage")
map("n", "<leader>lgu", "<cmd>GoCoverageToggle<cr>", "Toggle coverage")

-- Generation and refactoring
map("n", "<leader>lgj", "<cmd>GoAddTag json<cr>", "Add JSON tags")
map("n", "<leader>lgy", "<cmd>GoAddTag yaml<cr>", "Add YAML tags")
map("n", "<leader>lgr", "<cmd>GoRmTag<cr>", "Remove struct tags")
map("n", "<leader>lgs", "<cmd>GoFillStruct<cr>", "Fill struct")
map("n", "<leader>lgS", "<cmd>GoFillSwitch<cr>", "Fill switch")
map("n", "<leader>lge", "<cmd>GoIfErr<cr>", "Insert if err")
map("v", "<leader>lgj", ":<C-u>GoAddTag json<cr>", "Add JSON tags")
map("v", "<leader>lgy", ":<C-u>GoAddTag yaml<cr>", "Add YAML tags")
map("v", "<leader>lgr", ":<C-u>GoRmTag<cr>", "Remove struct tags")

-- Navigation, build, and modules
map("n", "<leader>lgA", "<cmd>GoAlt<cr>", "Alternate test/source")
map("n", "<leader>lgi", "<cmd>GoImpl<cr>", "Implement interface")
map("n", "<leader>lgd", "<cmd>GoDoc<cr>", "Documentation")
map("n", "<leader>lgb", "<cmd>GoBuild<cr>", "Build")
map("n", "<leader>lgR", "<cmd>GoRun<cr>", "Run")
map("n", "<leader>lgg", "<cmd>GoGenerate<cr>", "Run go generate")
map("n", "<leader>lgD", "<cmd>GoDebug<cr>", "Debug")
map("n", "<leader>lgB", "<cmd>GoBreakToggle<cr>", "Toggle breakpoint")
map("n", "<leader>lgmt", "<cmd>GoModTidy<cr>", "Mod tidy")
map("n", "<leader>lgmi", "<cmd>GoModInit<cr>", "Mod init")
map("n", "<leader>lgmg", "<cmd>GoGet<cr>", "Get dependency")
map("n", "<leader>lgl", "<cmd>GoLint<cr>", "golangci-lint")
map("n", "<leader>lgv", "<cmd>GoVet<cr>", "Vet")
map("n", "<leader>lgI", "<cmd>GoImport<cr>", "Add import")
map("n", "<leader>lgF", function()
	require("conform").format({ async = true, formatters = { "goimports", "gofumpt" } })
end, "Format with Conform")

-- DAP mappings are intentionally buffer-local.
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
	map("n", "<leader>dc", dap.continue, "Debug continue")
	map("n", "<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
	map("n", "<leader>di", dap.step_into, "Step into")
	map("n", "<leader>do", dap.step_over, "Step over")
	map("n", "<leader>dO", dap.step_out, "Step out")
	map("n", "<leader>dr", dap.repl.toggle, "Toggle debug REPL")
	map("n", "<leader>dl", dap.run_last, "Run last debug session")
	map("n", "<leader>dt", dap.terminate, "Terminate debug session")
end
