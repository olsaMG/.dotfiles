local null_ls = require("null-ls")

local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local sources = {

	-- webdev stuff
	-- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	b.formatting.prettier, --.with { filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars" } }, -- so prettier works only on these filetypes
	-- b.diagnostics.eslint,

	-- Lua
	b.formatting.stylua,

	-- cpp
	b.formatting.clang_format,

	--Java
	b.formatting.google_java_format,

	-- Go
	b.formatting.gofumpt,
	b.formatting.goimports_reviser,
	b.formatting.golines,

	-- Diagnostics
	-- b.diagnostics.eslint,

	-- Code actions
	-- b.code_actions.eslint,
}

null_ls.setup({
	debug = true,
	sources = sources,

	-- Format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
