return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"vimls",
				"clangd",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"ruff",
			},
			automatic_enable = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", {
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
				root_markers = {
					"init.lua",
					".luarc.json",
					".luarc.jsonc",
					".git",
				},
				capabilities = capabilities,
			})
			vim.lsp.config("clangd", {
				cmd = { "clangd", "--clang-tidy" },
				capabilities = capabilities,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local o = function(desc)
						return { buffer = ev.buf, desc = desc }
					end
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, o("Go to definition"))
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, o("References"))
					vim.keymap.set("n", "<leader>rn", "n", o("Rename"))
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, o("Code action"))
					-- Show diagnostic details in a popup
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, o("Show diagnostics"))

					-- Jump between diagnostics
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, o("Next diagnostic"))

					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, o("Previous diagnostic"))
				end,
			})
		end,
	},
}
