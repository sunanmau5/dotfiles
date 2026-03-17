return {
    "saghen/blink.cmp",
    version = "*", -- use pre-built Rust binaries, no toolchain required
    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
        }, -- <C-space> trigger, <CR> accept, <C-e> close
        appearance = { nerd_font_variant = "mono" },
        completion = {
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
}
