return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local theme = require("lualine.themes.ayu_mirage")
		for _, mode in pairs(theme) do
			if mode.c then mode.c.bg = "NONE" end
		end
		return {
			options = {
				theme = theme,
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { statusline = { "neo-tree" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
}