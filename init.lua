-- Font - Thử các font này (uncomment font bạn muốn)
-- vim.o.guifont = "JetBrains Mono:h16"
-- vim.o.guifont = "Fira Code:h16"
-- vim.o.guifont = "Cascadia Code:h16"
-- vim.o.guifont = "Monaspace Neon:h16"
vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h17"
-- Cursor animations - Mượt mà hơn, chậm hơn
vim.g.neovide_cursor_animation_length = 0.18
vim.g.neovide_cursor_trail_size = 0.9

-- Cursor VFX - Dùng effect nhẹ nhàng
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 7.0

-- Scroll animation - Mượt hơn
vim.g.neovide_scroll_animation_length = 0.5
vim.g.neovide_scroll_animation_far_lines = 1

-- Transparency - Nhìn thấy hình nền phía sau
vim.g.neovide_opacity = 0.5
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 4.0
vim.g.neovide_floating_blur_amount_y = 4.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

-- Performance
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = false

-- Padding
vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 5
vim.g.neovide_padding_right = 5
vim.g.neovide_padding_left = 5

-- Additional settings
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_input_macos_alt_is_meta = true

-- Cursor particles
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125

-- Antialiasing
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_smooth_blink = true

-- ============================================
-- BASIC SETTINGS
-- ============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tắt LSP progress notifications (toast notifications)
vim.lsp.handlers["$/progress"] = function() end

vim.opt.number = true
vim.opt.relativenumber = true
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
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.termguicolors = true

-- Tab settings - SET TO 4 SPACES
vim.opt.tabstop = 4 -- Số space hiển thị cho 1 tab
vim.opt.shiftwidth = 4 -- Số space khi indent (>>, <<, ==)
vim.opt.softtabstop = 4 -- Số space khi nhấn Tab trong insert mode
vim.opt.expandtab = true -- Convert tab thành space
vim.opt.smartindent = true

-- ============================================
-- KEY MAPPINGS
-- ============================================
-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Save file
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Buffer navigation - DI CHUYỂN NHANH GIỮA CÁC FILE
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Delete other buffers" })
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "Buffer picker" })

-- Terminal mappings - MỞ TERMINAL TRONG NEOVIM
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float terminal" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", { desc = "Vertical terminal" })
vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Diagnostic navigation - NHẢY ĐÉN ERROR/WARNING
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous error" })
vim.keymap.set("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })
vim.keymap.set("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Previous warning" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", { desc = "List all diagnostics" })

-- ============================================
-- BOOTSTRAP LAZY.NVIM
-- ============================================
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

-- ============================================
-- PLUGINS
-- ============================================
require("lazy").setup({
	-- ============================================
	-- THEMES - Uncomment theme bạn thích
	-- ============================================

	-- 1. Catppuccin (Hiện tại) - Pastel, mềm mại
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- Thử: latte, frappe, macchiato, mocha
				transparent_background = true,
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = { "bold" },
					keywords = { "italic" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = { "bold" },
					properties = {},
					types = { "bold" },
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					neo_tree = true,
					telescope = {
						enabled = true,
					},
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- -- 2. Tokyo Night - Tối hơn, màu neon đẹp
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night", -- Thử: storm, moon, night, day
	-- 			transparent = true,
	-- 			terminal_colors = true,
	-- 			styles = {
	-- 				comments = { italic = true },
	-- 				keywords = { italic = true },
	-- 				functions = { bold = true },
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
	--
	--[[ 	3. Kanagawa - Theme Nhật Bản, màu trầm sang trọng ]]
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			transparent = true,
	-- 			theme = "wave", -- Thử: wave, dragon, lotus
	-- 			background = {
	-- 				dark = "wave",
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end,
	-- },
	--
	--[[ 	4. Rose Pine - Màu hồng nhẹ nhàng, sang trọng ]]
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "main", -- Thử: main, moon, dawn
	-- 			disable_background = true,
	-- 			disable_float_background = true,
	-- 			styles = {
	-- 				italic = true,
	-- 				bold = true,
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },
	--
	-- 5. Nightfox - Nhiều variant, tùy chỉnh cao
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			options = {
	-- 				transparent = true,
	-- 				terminal_colors = true,
	-- 				styles = {
	-- 					comments = "italic",
	-- 					keywords = "italic",
	-- 					functions = "bold",
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("nightfox") -- Thử: nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
	-- 	end,
	-- },
	--
	-- 6. Gruvbox Material - Classic, ấm áp
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
	-- 		vim.g.gruvbox_material_transparent_background = 1
	-- 		vim.g.gruvbox_material_enable_italic = 1
	-- 		vim.g.gruvbox_material_enable_bold = 1
	-- 		vim.cmd.colorscheme("gruvbox-material")
	-- 	end,
	-- },
	--
	-- 7. Nord - Màu xanh dương cực đẹp
	-- {
	-- 	"shaunsingh/nord.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.nord_contrast = true
	-- 		vim.g.nord_borders = false
	-- 		vim.g.nord_disable_background = true
	-- 		vim.cmd.colorscheme("nord")
	-- 	end,
	-- },
	--
	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
			{ "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				window = {
					width = 30,
				},
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})
		end,
	},

	-- Fuzzy finder - ĐÃ FIX GREP
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					file_ignore_patterns = { "node_modules", ".git", "dist", "build" },
					layout_config = {
						horizontal = {
							preview_width = 0.55,
						},
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
				},
			})

			pcall(telescope.load_extension, "fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep text (tìm kiếm nội dung)" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
		end,
	},

	-- Treesitter - ĐÃ THÊM FRONTEND & JAVA
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- Go
					"go",
					"gomod",
					"gosum",
					-- Java
					"java",
					-- Frontend (bỏ jsx vì nó đã được bao gồm trong tsx)
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"tsx",
					"vue",
					"svelte",
					"astro",
					-- Config
					"json",
					"yaml",
					"toml",
					-- Lua/Vim
					"lua",
					"vim",
					"vimdoc",
					-- Other
					"markdown",
					"markdown_inline",
					"bash",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},

	-- LSP Configuration - ĐÃ THÊM FRONTEND & JAVA
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
					map("gr", require("telescope.builtin").lsp_references, "Goto References")
					map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				-- Go
				gopls = {
					settings = {
						gopls = {
							analyses = { unusedparams = true },
							staticcheck = true,
							gofumpt = true,
						},
					},
				},
				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				-- TypeScript/JavaScript
				ts_ls = {},
				-- HTML
				html = {},
				-- CSS
				cssls = {},
				-- Tailwind
				tailwindcss = {},
				-- JSON
				jsonls = {},
				-- Java - Cấu hình đặc biệt cho Lombok
				jdtls = {
					settings = {
						java = {
							configuration = {
								runtimes = {},
							},
							eclipse = {
								downloadSources = true,
							},
							maven = {
								downloadSources = true,
							},
							implementationsCodeLens = {
								enabled = true,
							},
							referencesCodeLens = {
								enabled = true,
							},
							references = {
								includeDecompiledSources = true,
							},
							format = {
								enabled = true,
							},
						},
						signatureHelp = { enabled = true },
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
							},
						},
						contentProvider = { preferred = "fernflower" },
						extendedClientCapabilities = {
							progressReportProvider = false,
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							},
							useBlocks = true,
						},
					},
					init_options = {
						bundles = {},
						extendedClientCapabilities = {
							progressReportProvider = false,
						},
					},
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				},
			}

			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Go
					"gopls",
					"goimports",
					"gofumpt",
					"golangci-lint",
					-- Lua
					"lua_ls",
					"stylua",
					-- TypeScript/JavaScript
					"typescript-language-server",
					"prettier",
					"eslint_d",
					-- HTML/CSS
					"html-lsp",
					"css-lsp",
					"tailwindcss-language-server",
					-- JSON
					"json-lsp",
					-- Java
					"jdtls",
					"google-java-format",
				},
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	-- Go specific plugins
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
	},

	-- Java specific plugin
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},

	-- Terminal plugin
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<C-\>]],
				hide_numbers = true,
				shade_terminals = true,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 3,
				},
			})
		end,
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Auto close tags cho HTML/JSX
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"svelte",
			"xml",
		},
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		opts = {},
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},

	-- Which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
			},
		},
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					separator_style = "slant",
					always_show_bufferline = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					color_icons = true,
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							highlight = "Directory",
							text_align = "left",
						},
					},
				},
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				go = { "goimports", "gofumpt" },
				java = { "google-java-format" },
				lua = { "stylua" },
			},
			formatters = {
				-- Prettier sẽ tự động đọc .prettierrc.json của bạn
				-- Không cần prepend_args nữa
				["google-java-format"] = {
					prepend_args = { "--aosp" },
				},
			},
			format_on_save = {
				timeout_ms = 3000, -- Tăng từ 500ms lên 3000ms
				lsp_fallback = true,
			},
		},
	},

	-- Emmet cho HTML/CSS
	{
		"mattn/emmet-vim",
		ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	},
})

-- ============================================
-- AUTO COMMANDS
-- ============================================
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	command = "close",
})
