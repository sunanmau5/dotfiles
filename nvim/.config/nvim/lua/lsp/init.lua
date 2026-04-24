local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
local vue_plugin = {
    name = "@vue/typescript-plugin",
    location = vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
    enableForWorkspaceTypeScriptVersions = true,
}

vim.lsp.config("vtsls", {
    cmd = { "vtsls", "--stdio" },
    filetypes = tsserver_filetypes,
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
        vtsls = {
            autoUseWorkspaceTsdk = true,
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    on_attach = function(client)
        if client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider.full = vim.bo.filetype ~= "vue"
        end
    end,
})

vim.lsp.config("vue_ls", {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
            local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })
            local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
            local clients = {}
            vim.list_extend(clients, ts_clients)
            vim.list_extend(clients, vtsls_clients)

            if #clients == 0 then
                vim.notify(
                    "Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.",
                    vim.log.levels.ERROR
                )
                return
            end
            local ts_client = clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
                title = "vue_request_forward",
                command = "typescript.tsserverRequest",
                arguments = {
                    command,
                    payload,
                },
            }, { bufnr = context.bufnr }, function(_, r)
                local response = r and r.body
                local response_data = { { id, response } }
                ---@diagnostic disable-next-line: param-type-mismatch
                client:notify("tsserver/response", response_data)
            end)
        end
    end,
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

vim.lsp.config("elixirls", {
    cmd = { "elixir-ls" },
    filetypes = { "elixir", "eelixir", "heex", "surface" },
    root_markers = { "mix.exs", ".git" },
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

vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
})

vim.lsp.config("html", {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "templ" },
    root_markers = { "package.json", ".git" },
})

vim.lsp.config("tailwindcss", {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.mjs", ".git" },
})

vim.lsp.config("terraformls", {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars", "hcl" },
    root_markers = { ".terraform", ".git" },
})

vim.lsp.config("tflint", {
    cmd = { "tflint", "--langserver" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".tflint.hcl", ".terraform", ".git" },
})

vim.lsp.enable({
    "vtsls",
    "vue_ls",
    "lua_ls",
    "sqls",
    "marksman",
    "elixirls",
    "basedpyright",
    "ruff",
    "cssls",
    "html",
    "tailwindcss",
    "terraformls",
    "tflint",
})

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
        map({ "n", "i" }, "<leader>cs", vim.lsp.buf.signature_help, "Signature help")
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
