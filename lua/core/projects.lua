local M = {}

local function session_path()
	local cwd = vim.uv.cwd()
	local name = vim.fn.fnamemodify(cwd, ":t") .. "-" .. vim.fn.sha256(cwd):sub(1, 10) .. ".vim"
	return vim.fn.stdpath("state") .. "/sessions/" .. name
end

local function project_roots()
	local candidates = {
		vim.fn.expand("~/Code"),
		vim.fn.expand("~/Projects"),
		vim.fn.expand("~/work"),
	}
	local projects = {}
	local seen = {}

	for _, root in ipairs(candidates) do
		if vim.fn.isdirectory(root) == 1 then
			for _, pattern in ipairs({ "*/.git", "*/*/.git" }) do
				for _, git_dir in ipairs(vim.fn.globpath(root, pattern, false, true)) do
					local project = vim.fs.dirname(git_dir)
					if project and not seen[project] then
						seen[project] = true
						table.insert(projects, project)
					end
				end
			end
		end
	end

	table.sort(projects)
	return projects
end

function M.find()
	local projects = project_roots()
	if #projects == 0 then
		vim.notify("No Git projects found under ~/Code, ~/Projects, or ~/work", vim.log.levels.WARN)
		return
	end

	local ok, pickers = pcall(require, "telescope.pickers")
	if not ok then
		vim.ui.select(projects, { prompt = "Projects" }, function(project)
			if project then
				vim.cmd.cd(vim.fn.fnameescape(project))
			end
		end)
		return
	end

	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Projects",
			finder = finders.new_table({ results = projects }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local project = action_state.get_selected_entry()[1]
					actions.close(prompt_bufnr)
					vim.cmd.cd(vim.fn.fnameescape(project))
					require("telescope.builtin").find_files({ cwd = project, hidden = true })
				end)
				return true
			end,
		})
		:find()
end

function M.save_session()
	local path = session_path()
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	vim.cmd.mksession({ args = { path }, bang = true })
	vim.notify("Saved project session", vim.log.levels.INFO, { title = "Projects" })
end

function M.load_session()
	local path = session_path()
	if vim.fn.filereadable(path) ~= 1 then
		vim.notify("No saved session for " .. vim.uv.cwd(), vim.log.levels.WARN, { title = "Projects" })
		return
	end
	vim.cmd.source(path)
end

vim.api.nvim_create_user_command("FindProjects", M.find, { desc = "Find a Git project" })
vim.api.nvim_create_user_command("ProjectSessionSave", M.save_session, { desc = "Save the current project session" })
vim.api.nvim_create_user_command("ProjectSessionLoad", M.load_session, { desc = "Load the current project session" })

return M
