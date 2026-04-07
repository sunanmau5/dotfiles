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
            "vue",
            "yaml",
        }

        vim.defer_fn(function()
            ts.install(parsers):wait(300000)
        end, 0)

        local filetypes = vim.tbl_map(function(lang)
            return vim.treesitter.language.get_filetypes(lang)
        end, parsers)
        filetypes = vim.iter(filetypes):flatten():totable()

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
