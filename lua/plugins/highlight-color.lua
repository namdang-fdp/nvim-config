return {
	"NvChad/nvim-colorizer.lua",
	ft = { "css", "scss", "sass", "less", "html", "javascript", "javascriptreact", "typescriptreact", "vue", "svelte" },
	config = function()
		require("colorizer").setup({
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				mode = "virtualtext",
				tailwind = true, -- Enable tailwind colors
				sass = { enable = true, parsers = { "css" } },
				virtualtext = "■",
			},
			buftypes = { "*" },
		})
	end,
}
