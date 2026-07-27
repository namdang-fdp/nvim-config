local M = {}

local max_bytes = 1024 * 1024
local max_lines = 20000

local group = vim.api.nvim_create_augroup("bigfile-guard", { clear = true })

local function mark_bigfile(bufnr, reason)
	if vim.b[bufnr].bigfile then
		return
	end

	vim.b[bufnr].bigfile = true
	vim.b[bufnr].format_on_save = false
	vim.bo[bufnr].swapfile = false
	vim.bo[bufnr].undofile = false

	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(bufnr) then
			pcall(vim.treesitter.stop, bufnr)
			vim.diagnostic.enable(false, { bufnr = bufnr })
			if package.loaded.ibl then
				pcall(require("ibl").setup_buffer, bufnr, { enabled = false })
			end
			if package.loaded.colorizer then
				pcall(require("colorizer").detach_from_buffer, bufnr)
			end
			vim.notify(
				("Large-file mode enabled (%s)"):format(reason),
				vim.log.levels.INFO,
				{ title = "Performance" }
			)
		end
	end)
end

vim.api.nvim_create_autocmd("BufReadPre", {
	group = group,
	callback = function(args)
		local name = vim.api.nvim_buf_get_name(args.buf)
		if name == "" then
			return
		end

		local stat = vim.uv.fs_stat(name)
		if stat and stat.size > max_bytes then
			mark_bigfile(args.buf, ("%.1f MiB"):format(stat.size / 1024 / 1024))
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function(args)
		if not vim.b[args.buf].bigfile then
			local lines = vim.api.nvim_buf_line_count(args.buf)
			if lines > max_lines then
				mark_bigfile(args.buf, ("%d lines"):format(lines))
			end
		end
	end,
})

return M
