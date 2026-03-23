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

        local languages = {
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "ruby",
            "sql",
            "python",
            "javascript",
            "typescript",
            "tsx",
            "json",
        }

        ts.install(languages, { summary = false }):wait(30000)

        local function install_parser_and_enable_features(args)
            local ok, task = pcall(ts.install, { args.match }, { summary = false })
            if ok then
                task:wait(10000)
            end
            pcall(vim.treesitter.start, args.buf)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
            pattern = languages,
            callback = install_parser_and_enable_features,
        })
    end,
}
