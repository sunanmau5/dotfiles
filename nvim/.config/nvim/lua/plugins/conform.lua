return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            python = { "ruff_format" },
            terraform = { "terraform_fmt" },
            ["terraform-vars"] = { "terraform_fmt" },
            hcl = { "terraform_fmt" },
        },
        format_on_save = nil,
    },
}
