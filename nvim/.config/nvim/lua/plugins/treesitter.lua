return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()
        treesitter.install({
            "lua",
            "ruby",
            "sql",
            "markdown",
            "markdown_inline",
            "python",
            "vim",
            "vimdoc",
            "javascript",
            "typescript",
            "tsx",
            "json",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "lua",
                "ruby",
                "sql",
                "markdown",
                "markdown_inline",
                "python",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "tsx",
                "json",
            },
            callback = function()
                -- syntax highlighting, provided by Neovim
                vim.treesitter.start()
                -- folds, provided by Neovim (I don't like folds)
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'
                -- indentation, provided by nvim-treesitter
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
