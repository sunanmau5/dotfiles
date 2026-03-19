return {
    "coder/claudecode.nvim",
    keys = {
        { "<leader>ac", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle Claude" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send to Claude", mode = { "n", "v" } },
    },
    opts = {
        terminal = {
            provider = "native",
            show_native_term_exit_tip = false,
        },
    },
}
