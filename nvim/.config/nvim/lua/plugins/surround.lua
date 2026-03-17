return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "gs", "<Plug>(nvim-surround-visual)", mode = "x", desc = "Surround visual selection" },
        { "gS", "<Plug>(nvim-surround-visual-line)", mode = "x", desc = "Surround visual selection (line)" },
    },
}
