return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	opts = function()
		local bufferline = require("bufferline")
		return {
			options = {
				style_preset = {
					bufferline.style_preset.no_italic,
					bufferline.style_preset.no_bold,
				},
				always_show_bufferline = false,
				show_buffer_icons = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				indicator = { style = "none" },
			},
			highlights = {
				buffer_selected = {
					fg = "#1f2430",
					bg = "#ffcc66",
					bold = false,
					italic = false,
				},
				modified_selected = {
					fg = "#1f2430",
					bg = "#ffcc66",
					bold = false,
					italic = false,
				},
			},
		}
	end,
}
