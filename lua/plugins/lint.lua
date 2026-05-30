-- ============================================
-- LINTING CONFIGURATION (ESLint realtime)
-- ============================================
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Configure linters per filetype
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "ruff" }, -- hoặc "pylint"
		}

		-- C/C++ static analysis với clang-tidy (bundled với LLVM/clangd)
		if vim.fn.executable("clang-tidy") == 1 then
			lint.linters_by_ft.cpp = { "clangtidy" }
			lint.linters_by_ft.c   = { "clangtidy" }

			-- Trỏ clang-tidy đến compile_commands.json nếu có
			lint.linters.clangtidy = vim.tbl_deep_extend("force", lint.linters.clangtidy or {}, {
				args = function()
					local args = { "--use-color=0" }
					-- Tìm compile_commands.json từ thư mục hiện tại lên root
					local cwd = vim.fn.getcwd()
					if vim.fn.filereadable(cwd .. "/compile_commands.json") == 1 then
						vim.list_extend(args, { "-p", cwd })
					elseif vim.fn.filereadable(cwd .. "/build/compile_commands.json") == 1 then
						vim.list_extend(args, { "-p", cwd .. "/build" })
					end
					return args
				end,
			})
		end


		-- Auto-lint on save and when entering buffer
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Manual lint keybinding
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })
	end,
}
