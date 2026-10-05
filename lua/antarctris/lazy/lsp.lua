return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
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

		-- Replaces virtual text diagnostics, which are off by default since Neovim 0.11
		require("tiny-inline-diagnostic").setup()

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
				{ name = "lazydev", group_index = 0 }, -- Neovim API completion, only active in lua files
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Applies to every server, including the ones mason-lspconfig enables automatically
		vim.lsp.config("*", { capabilities = capabilities })
		require("mason-lspconfig").setup({})

		-- cmd, filetypes and root_markers come from nvim-lspconfig's lsp/<name>.lua
		vim.lsp.config("dartls", {
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		})
		vim.lsp.enable({ "dartls", "stylua" })

		-- Not installed by mason (its binaries often fail on NixOS), so only enable it if present
		if vim.fn.executable("lua-language-server") == 1 then
			vim.lsp.config("lua_ls", {
				on_init = function(client)
					-- Leave formatting to stylua
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})
			vim.lsp.enable("lua_ls")
		end

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})

		-- grn (rename) and insert-mode <C-s> (signature help) are Neovim defaults
		vim.keymap.set("n", "gm", vim.lsp.buf.hover)
		vim.keymap.set("n", "gca", vim.lsp.buf.code_action)
		-- Exported to telescope:
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		-- vim.keymap.set("n", "grr", vim.lsp.buf.references)
		-- vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
		-- vim.keymap.set("n", "gdm", vim.diagnostic.open_float)
		vim.keymap.set("n", "g[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		vim.keymap.set("n", "g]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)

		-- Format on save, but only in buffers with an attached LSP that can format
		local format_group = vim.api.nvim_create_augroup("lsp_format", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = format_group,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client or not client:supports_method("textDocument/formatting") then
					return
				end
				vim.api.nvim_clear_autocmds({ group = format_group, event = "BufWritePre", buffer = args.buf })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = format_group,
					buffer = args.buf,
					callback = function()
						vim.lsp.buf.format({ bufnr = args.buf })
					end,
				})
			end,
		})
	end,
}
