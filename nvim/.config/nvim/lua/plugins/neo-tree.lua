return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>" },
		{ "<leader>E", "<cmd>Neotree toggle dir=%:p:h<cr>" },
	},
	opts = {
		hijack_netrw_behavior = "open_current",
		window = {
			position = "right",
			width = 35,
			mappings = {
				["h"] = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				["l"] = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then
							state.commands.toggle_node(state)
						else
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					else
						require("neo-tree.sources.filesystem.commands").open(state)
					end
				end,
			},
		},
		default_component_configs = {
			indent = { with_expanders = true },
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "neo-tree",
			callback = function()
				vim.opt_local.signcolumn = "no"
				vim.opt_local.foldcolumn = "0"
			end,
		})
		require("neo-tree").setup(opts)
	end,
}
