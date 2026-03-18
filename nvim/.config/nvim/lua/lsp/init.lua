vim.lsp.config("vtsls", {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    settings = {
        typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = { completeFunctionCalls = true },
        },
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = { completeFunctionCalls = true },
        },
        vtsls = { autoUseWorkspaceTsdk = true },
    },
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", "stylua.toml", ".git" },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.config("sqls", {
    cmd = { "sqls" },
    filetypes = { "sql" },
})

vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
})

vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
                -- let ruff handle these
                ignore = { "*" },
            },
        },
    },
})

vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
})

vim.lsp.enable({ "vtsls", "lua_ls", "sqls", "marksman", "basedpyright", "ruff" })

vim.diagnostic.config({
    virtual_text = false, -- signs + underline are enough; use <leader>cd for details
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "Go to references")
        map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Diagnostic details")
        map("n", "<leader>ci", function()
            vim.lsp.buf.code_action({
                apply = true,
                context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
            })
        end, "Add missing imports")
        map("n", "<leader>co", function()
            vim.lsp.buf.code_action({
                apply = true,
                context = { only = { "source.organizeImports.ts" }, diagnostics = {} },
            })
        end, "Organize imports")
    end,
})
