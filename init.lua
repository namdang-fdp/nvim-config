-- ============================================
-- NEOVIM CONFIGURATION - MAIN ENTRY POINT
-- ============================================

-- Load Neovide settings first (if running in Neovide)
require("core.neovide")

-- Load core settings
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
