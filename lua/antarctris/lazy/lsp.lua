return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"rachartier/tiny-inline-diagnostic.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Replace Neovim's default virtual text diagnostics
		require("tiny-inline-diagnostic").setup()
		vim.diagnostic.config({ virtual_text = false })

		require("fidget").setup({})
		require("mason").setup({
			PATH = "append",
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-h>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-k>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-u>"] = cmp.mapping.abort(),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		vim.lsp.config("dartls", {
			cmd = { "dart", "language-server", "--protocol=lsp" },
			filetypes = { "dart" },
			root_markers = { "pubspec.yaml" },
			capabilities = capabilities,
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		})
		vim.lsp.enable("dartls")

		vim.lsp.config("stylua_lsp", {
			cmd = { "stylua", "--lsp" },
			filetypes = { "lua" }, -- maybe also "luau" if you use that
			root_markers = { ".git", ".stylua.toml", "stylua.toml" }, -- optional/project-specific
		})
		vim.lsp.enable("stylua_lsp")

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		vim.keymap.set("n", "gm", vim.lsp.buf.hover)
		vim.keymap.set("n", "grn", vim.lsp.buf.rename)
		vim.keymap.set("n", "gca", vim.lsp.buf.code_action)
		vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
		-- Exported to telescope:
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		-- vim.keymap.set("n", "grr", vim.lsp.buf.references)
		-- vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
		-- vim.keymap.set("n", "gdm", vim.diagnostic.open_float)
		vim.keymap.set("n", "g[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "g]d", vim.diagnostic.goto_next)

		vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
	end,
}
