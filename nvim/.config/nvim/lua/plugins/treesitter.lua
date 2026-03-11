return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"json",
				"lua",
				"ruby",
				"sql",
				"markdown",
				"markdown_inline",
				"python",
				"vim",
				"vimdoc",
			},
			highlight = { enable = true },
		})
	end,
}
