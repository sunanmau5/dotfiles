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

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
            pattern = "*",
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then
                    return
                end
                if not pcall(vim.treesitter.language.inspect, lang) then
                    local ok, task = pcall(ts.install, { lang }, { summary = false })
                    if ok then
                        task:wait(10000)
                    end
                end
                pcall(vim.treesitter.start, args.buf)
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
