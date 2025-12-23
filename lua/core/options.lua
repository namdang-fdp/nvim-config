-- ============================================
-- BASIC VIM OPTIONS
-- ============================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tắt LSP progress notifications
vim.lsp.handlers["$/progress"] = function() end

-- Tắt tất cả các notifications không cần thiết
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
	if msg:match("gofumpt") then
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

	-- Chỉ hiện errors thực sự
	if level == vim.log.levels.ERROR then
		notify(msg, level, opts)
	end
end

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

-- Tắt các messages dài
vim.opt.shortmess:append("c")
vim.opt.shortmess:append("F")

-- Tắt cmdheight để bớt "Press ENTER"
vim.opt.cmdheight = 1
