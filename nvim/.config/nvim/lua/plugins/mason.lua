return {
    { "mason-org/mason.nvim", opts = {} },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                -- LSP servers
                "basedpyright",
                "css-lsp",
                "html-lsp",
                "lua-language-server",
                "marksman",
                "ruff",
                "tailwindcss-language-server",
                "vue-language-server",
                "vtsls",
                -- Formatters / linters
                "markdown-toc",
                "markdownlint-cli2",
                "prettier",
                "shfmt",
                "stylua",
                -- Other
                "tree-sitter-cli",
            },
        },
    },
}
