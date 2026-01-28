return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	keys = {
		{ "<leader><leader>", "<cmd>Telescope find_files hidden=true<cr>" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
	},
	opts = {
		defaults = {
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
		},
		pickers = {
			find_files = { hidden = true },
			live_grep = { additional_args = { "--hidden" } },
		},
	},
}
