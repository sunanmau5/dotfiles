return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        indent = {
            char = "│",
        },
        scope = {
            enabled = true,
            injected_languages = true,
            show_start = false,
            show_end = false,
            include = {
                node_type = {
                    javascript = { "object", "object_pattern" },
                    typescript = { "object", "object_pattern", "type_literal" },
                    vue = { "object", "object_pattern" },
                },
            },
        },
        exclude = {
            filetypes = { "help", "markdown", "text", "rst" },
        },
    },
}
