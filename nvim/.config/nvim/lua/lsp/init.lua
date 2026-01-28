vim.lsp.config("vtsls", {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
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

vim.lsp.enable({ "vtsls", "lua_ls", "sqls", "marksman" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = args.buf })
		end
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "gr", vim.lsp.buf.references)
		map("n", "gy", vim.lsp.buf.type_definition)
		map("n", "<leader>cr", vim.lsp.buf.rename)
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		map("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end)
	end,
})
