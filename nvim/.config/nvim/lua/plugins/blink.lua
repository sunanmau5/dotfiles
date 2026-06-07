return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
    end,
    version = "1.*",
    opts = {
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            accept = {
                auto_brackets = { enabled = false },
            },
        },
        signature = { enabled = true },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
