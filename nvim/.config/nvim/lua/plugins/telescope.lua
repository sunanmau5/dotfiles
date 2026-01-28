return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-frecency.nvim", version = "*" },
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("frecency")
	end,
	cmd = "Telescope",
	keys = {
		{ "<C-p>", "<cmd>Telescope frecency workspace=CWD<cr>" },
		{ "<leader><leader>", "<cmd>Telescope frecency workspace=CWD<cr>" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>/", function() require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") }) end, mode = "v" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
	},
	opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<esc>"] = actions.close
          }
        }
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
      },
    }
  end
}
