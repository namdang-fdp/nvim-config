-- ============================================
-- NEOVIM CONFIGURATION - MAIN ENTRY POINT
-- ============================================

-- Load Neovide settings first (if running in Neovide)
require("core.neovide")

-- Load core settings
require("core.options")
require("core.diagnostic-config")
require("core.keymaps")
require("core.autocmds")
require("core.bigfile")
require("core.projects")
require("core.devtools")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local result = vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}, { text = true }):wait()
	if result.code ~= 0 then
		error("Failed to bootstrap lazy.nvim: " .. vim.trim(result.stderr or result.stdout or "unknown error"))
	end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
