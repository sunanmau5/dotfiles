return {
    {
        name = "floaterminal",
        dir = vim.fn.stdpath("config") .. "/local/floaterminal",
        cmd = "Floaterminal",
        keys = {
            {
                "<leader>tt",
                "<cmd>Floaterminal<cr>",
                mode = { "n", "t" },
                desc = "Toggle terminal",
            },
        },
    },
}
