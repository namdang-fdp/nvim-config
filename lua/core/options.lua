-- ============================================
-- BASIC VIM OPTIONS
-- ============================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.opt.background = "dark"
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.winborder = "rounded"
vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
}

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
vim.opt.linespace = 6
