return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local ts = require("nvim-treesitter")
        ts.setup()

        local parsers = {
            "bash",
            "css",
            "dockerfile",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "ruby",
            "sql",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        }

        vim.defer_fn(function()
            ts.install(parsers):wait(300000)
        end, 0)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = parsers,
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
