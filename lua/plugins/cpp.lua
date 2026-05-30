-- ============================================
-- C++ DEVELOPMENT SETUP
-- Tools: clangd (LSP), clang-format, cmake-tools, DAP debug
-- ============================================

return {
	-- ─── CMake Integration ───────────────────────────────────────────────────
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "cpp", "c", "cmake" },
		opts = {
			cmake_command = "cmake",
			cmake_build_directory = "build",
			cmake_build_directory_prefix = "build_",
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON", "-G", "Ninja" },
			cmake_build_options = { "--", "-j" .. (vim.loop.cpu_info and #vim.loop.cpu_info() or 4) },
			cmake_console_size = 10,
			cmake_console_position = "belowright",
			cmake_show_console = "always",
			cmake_executor = {
				name = "terminal",
				opts = {
					split_direction = "horizontal",
					split_size = 11,
				},
			},
			cmake_runner = {
				name = "terminal",
				opts = {
					split_direction = "horizontal",
					split_size = 11,
				},
			},
			cmake_notifications = {
				runner = { enabled = true },
				executor = { enabled = true },
			},
		},
		keys = {
			{ "<leader>cg", "<cmd>CMakeGenerate<cr>",        desc = "CMake: Generate" },
			{ "<leader>cb", "<cmd>CMakeBuild<cr>",           desc = "CMake: Build" },
			{ "<leader>cr", "<cmd>CMakeRun<cr>",             desc = "CMake: Run" },
			{ "<leader>cd", "<cmd>CMakeDebug<cr>",           desc = "CMake: Debug" },
			{ "<leader>cx", "<cmd>CMakeClean<cr>",           desc = "CMake: Clean" },
			{ "<leader>cs", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake: Select Build Type" },
			{ "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake: Select Target" },
		},
	},

	-- ─── DAP (Debug Adapter Protocol) ────────────────────────────────────────
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		ft = { "cpp", "c" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- ── DAP UI ────────────────────────────────────────────────────────
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes",      size = 0.35 },
							{ id = "breakpoints", size = 0.20 },
							{ id = "stacks",      size = 0.25 },
							{ id = "watches",     size = 0.20 },
						},
						size = 42,
						position = "left",
					},
					{
						elements = {
							{ id = "repl",    size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 0.25,
						position = "bottom",
					},
				},
			})

			-- ── Virtual text (show variable values inline) ────────────────────
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				commented = true,
				highlight_new_as_changed = true,
			})

			-- ── Auto open/close DAP UI ────────────────────────────────────────
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- ── C/C++ Adapter (codelldb via Mason) ────────────────────────────
			local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb"
			local codelldb_path = mason_path .. "/extension/adapter/codelldb"
			local liblldb_path = mason_path .. "/extension/lldb/lib/liblldb.so"

			if vim.fn.filereadable(codelldb_path) == 1 then
				dap.adapters.codelldb = {
					type = "server",
					port = "${port}",
					executable = {
						command = codelldb_path,
						args = { "--port", "${port}" },
					},
				}
			else
				-- Fallback: system lldb-dap / lldb-vscode
				dap.adapters.codelldb = {
					type = "executable",
					command = vim.fn.exepath("lldb-dap") ~= "" and "lldb-dap"
						or vim.fn.exepath("lldb-vscode") ~= "" and "lldb-vscode"
						or "lldb-dap",
					name = "lldb",
				}
			end

			-- ── C++ Debug configurations ──────────────────────────────────────
			dap.configurations.cpp = {
				{
					name = "Launch (ask for executable)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						local args_str = vim.fn.input("Arguments: ")
						if args_str == "" then return {} end
						return vim.split(args_str, " ")
					end,
					runInTerminal = false,
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.c = dap.configurations.cpp

			-- ── Keymaps ───────────────────────────────────────────────────────
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { desc = "DAP: " .. desc })
			end
			map("<F5>",      dap.continue,             "Continue / Start")
			map("<F10>",     dap.step_over,             "Step Over")
			map("<F11>",     dap.step_into,             "Step Into")
			map("<F12>",     dap.step_out,              "Step Out")
			map("<leader>bp", dap.toggle_breakpoint,   "Toggle Breakpoint")
			map("<leader>bP", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, "Conditional Breakpoint")
			map("<leader>dr", dap.repl.open,            "Open REPL")
			map("<leader>dl", dap.run_last,             "Run Last")
			map("<leader>du", dapui.toggle,             "Toggle DAP UI")
			map("<leader>dx", dap.terminate,            "Terminate")
		end,
	},

	-- ─── clangd Extensions (inlay hints, AST, type hierarchy) ───────────────
	{
		"p00f/clangd_extensions.nvim",
		ft = { "cpp", "c", "objc", "objcpp" },
		opts = {
			inlay_hints = {
				inline = false, -- shown as virtual text after line
				only_current_line = false,
				only_current_line_autocmd = "CursorHold",
				show_parameter_hints = true,
				parameter_hints_prefix = "« ",
				other_hints_prefix = "» ",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 7,
				highlight = "Comment",
				priority = 100,
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = ";",
					["template argument"] = "",
				},
			},
		},
	},

	-- ─── C++ snippets ─────────────────────────────────────────────────────────
	-- (friendly-snippets already has C++ via LuaSnip, this adds more)
	{
		"L3MON4D3/LuaSnip",
		-- already loaded by cmp.lua, just ensure friendly-snippets loads
		optional = true,
	},
}
