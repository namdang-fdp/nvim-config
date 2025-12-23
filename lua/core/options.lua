-- ============================================
-- BASIC VIM OPTIONS
-- ============================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tắt LSP progress notifications (không ảnh hưởng diagnostics)
vim.lsp.handlers["$/progress"] = function() end

-- Tắt các notifications KHÔNG QUAN TRỌNG (giữ lại errors!)
local notify = vim.notify
vim.notify = function(msg, level, opts)
	-- Chặn các messages không quan trọng
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end
	if msg:match("method textDocument") then
		return
	end
	if msg:match("method workspace") then
		return
	end
	if msg:match("formatting") then
		return
	end
	if msg:match("Press ENTER") then
		return
	end
	if msg:match("null-ls") then
		return
	end
	if msg:match("golangci_lint") then
		return
	end
	if msg:match("max_line_len") then
		return
	end
	if msg:match("Go development mode") then
		return
	end
	if msg:match("which-key") then
		return
	end

	-- QUAN TRỌNG: Vẫn hiện warnings và errors
	if level == vim.log.levels.WARN or level == vim.log.levels.ERROR then
		notify(msg, level, opts)
	end
end

-- ============================================
-- DIAGNOSTIC CONFIGURATION - HIỆN LỖI RÕ RÀNG
-- ============================================

-- Configure diagnostics display
vim.diagnostic.config({
	-- Hiện virtual text với lỗi
	virtual_text = {
		spacing = 4,
		prefix = "●",
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
	},
	-- Hiện signs ở sidebar
	signs = true,
	-- Update diagnostics khi typing (để thấy lỗi ngay)
	update_in_insert = false,
	-- Underline text có lỗi
	underline = true,
	-- Severity sort
	severity_sort = true,
	-- Float window khi hover
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Define diagnostic signs
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- ============================================
-- BASIC SETTINGS
-- ============================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- General settings
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.termguicolors = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- List chars
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"

-- Tắt các messages dài (không ảnh hưởng diagnostics)
vim.opt.shortmess:append("c")
vim.opt.shortmess:append("F")

-- Cmdheight
vim.opt.cmdheight = 1
