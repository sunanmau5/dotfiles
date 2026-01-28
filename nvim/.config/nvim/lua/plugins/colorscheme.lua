return {
	"Shatur/neovim-ayu",
	lazy = false,
	priority = 1000,
	opts = {
		mirage = true,
		overrides = {
			Normal = { bg = "NONE" },
			NormalNC = { bg = "NONE" },
			NormalFloat = { bg = "NONE" },
			FloatBorder = { bg = "NONE" },
			-- line numbers (brighter for visibility on transparent bg)
			LineNr = { fg = "#5c6773" },
			CursorLineNr = { fg = "#ffcc66" },
			-- statusline
			StatusLine = { bg = "NONE" },
			StatusLineNC = { bg = "NONE" },
			-- neo-tree
			NeoTreeNormal = { bg = "NONE" },
			NeoTreeNormalNC = { bg = "NONE" },
			NeoTreeWinSeparator = { fg = "NONE", bg = "NONE" },
			WinSeparator = { fg = "NONE", bg = "NONE" },
			NeoTreeEndOfBuffer = { fg = "NONE", bg = "NONE" },
			EndOfBuffer = { fg = "NONE" },
			-- gitsigns
			GitSignsAdd = { bg = "NONE" },
			GitSignsChange = { bg = "NONE" },
			GitSignsDelete = { bg = "NONE" },
			SignColumn = { bg = "NONE" },
			-- bufferline / tabline
			TabLineFill = { bg = "NONE" },
		},
	},
	config = function(_, opts)
		require("ayu").setup(opts)
		vim.cmd.colorscheme("ayu")
	end,
}
