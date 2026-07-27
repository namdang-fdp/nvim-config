-- The only active colorscheme. The palette intentionally replaces Kanagawa's
-- blue popup/function accents with warm graphite, amber, and restrained coral
-- so Neovim remains distinct from a blue desktop wallpaper.
return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			transparent = false,
			dimInactive = true,
			terminalColors = true,
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
			colors = {
				palette = {
					sumiInk0 = "#141312",
					sumiInk1 = "#181616",
					sumiInk2 = "#211f1c",
					sumiInk3 = "#2a2621",
					sumiInk4 = "#4b443c",
					waveBlue1 = "#2b2722",
					waveBlue2 = "#3a3126",
					fujiWhite = "#dcd7ba",
					oldWhite = "#c8c093",
					carpYellow = "#e6c384",
					boatYellow2 = "#c9a96e",
					crystalBlue = "#d6b06b",
					springBlue = "#c4a46b",
					oniViolet = "#c98d6b",
					springViolet1 = "#d4c8b0",
					springViolet2 = "#bdae96",
					autumnGreen = "#76946a",
					autumnRed = "#c4746e",
					autumnYellow = "#dca561",
					samuraiRed = "#e46876",
					roninYellow = "#e6c384",
					waveAqua1 = "#7f9a77",
					dragonBlue = "#9b927f",
				},
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
					dragon = {
						ui = {
							bg = "#181616",
							bg_dim = "#141312",
							bg_m1 = "#161514",
							bg_m2 = "#141312",
							bg_m3 = "#121110",
							bg_p1 = "#211f1c",
							bg_p2 = "#2a2621",
							special = "#e6c384",
							float = {
								bg = "#211f1c",
								bg_border = "#5a4d3d",
							},
							pmenu = {
								bg = "#211f1c",
								bg_sel = "#3a3126",
								bg_sbar = "#2a2621",
								bg_thumb = "#5a4d3d",
							},
						},
					},
				},
			},
			overrides = function(colors)
				local p = colors.palette
				local float_bg = "#211f1c"
				local border = "#6b5945"

				return {
					Normal = { fg = p.fujiWhite, bg = "#181616" },
					NormalNC = { fg = p.oldWhite, bg = "#161514" },
					NormalFloat = { fg = p.fujiWhite, bg = float_bg },
					FloatBorder = { fg = border, bg = float_bg },
					FloatTitle = { fg = p.carpYellow, bg = float_bg, bold = true },
					WinSeparator = { fg = "#3a342e", bg = "#181616" },
					CursorLine = { bg = "#211f1c" },
					Visual = { bg = "#3a3126" },
					Search = { fg = "#181616", bg = p.carpYellow },
					IncSearch = { fg = "#181616", bg = p.surimiOrange },
					Pmenu = { fg = p.fujiWhite, bg = float_bg },
					PmenuSel = { fg = "#181616", bg = p.carpYellow, bold = true },
					PmenuSbar = { bg = "#2a2621" },
					PmenuThumb = { bg = border },
					TelescopeNormal = { fg = p.fujiWhite, bg = float_bg },
					TelescopeBorder = { fg = border, bg = float_bg },
					TelescopePromptNormal = { fg = p.fujiWhite, bg = "#2a2621" },
					TelescopePromptBorder = { fg = p.carpYellow, bg = "#2a2621" },
					TelescopePromptTitle = { fg = "#181616", bg = p.carpYellow, bold = true },
					TelescopeSelection = { fg = p.fujiWhite, bg = "#3a3126", bold = true },
					CmpItemAbbrMatch = { fg = p.carpYellow, bold = true },
					CmpItemAbbrMatchFuzzy = { fg = p.autumnYellow, bold = true },
					DiagnosticVirtualTextError = { fg = p.samuraiRed, bg = "#251b1a" },
					DiagnosticVirtualTextWarn = { fg = p.roninYellow, bg = "#28231a" },
					DiagnosticVirtualTextInfo = { fg = p.waveAqua1, bg = "#1c231c" },
					DiagnosticVirtualTextHint = { fg = p.dragonBlue, bg = "#22201c" },
					NotifyBackground = { bg = float_bg },
					NeoTreeNormal = { fg = p.oldWhite, bg = "#181616" },
					NeoTreeNormalNC = { fg = p.oldWhite, bg = "#181616" },
					NeoTreeFloatNormal = { fg = p.oldWhite, bg = float_bg },
					NeoTreeFloatBorder = { fg = border, bg = float_bg },
					WhichKeyFloat = { bg = float_bg },
					NoiceCmdlinePopup = { bg = float_bg },
					NoiceCmdlinePopupBorder = { fg = border, bg = float_bg },
					NoiceCmdlineIcon = { fg = p.carpYellow },
					LazyNormal = { fg = p.oldWhite, bg = float_bg },
					MasonNormal = { fg = p.oldWhite, bg = float_bg },
				}
			end,
		})

		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
