return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		workspaces = {
			{ name = "vault", path = "~/Documents/obsidian/vault" },
			{ name = "cloud-storage", path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/cloud-storage" },
		},
		disable_frontmatter = true,
		callbacks = {
			enter_note = function()
				vim.opt.conceallevel = 2
			end,
			leave_note = function()
				vim.opt.conceallevel = 0
			end,
		},
	},
}
