return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
        {
            "<leader>cl",
            function()
                require("lint").try_lint()
            end,
            desc = "Lint",
        },
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            javascript = { "biomejs" },
            javascriptreact = { "biomejs" },
            typescript = { "biomejs" },
            typescriptreact = { "biomejs" },
            markdown = { "markdownlint-cli2" },
            terraform = { "tflint" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
