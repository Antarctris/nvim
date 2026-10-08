return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
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

		-- Applies to every server, including the auto-enabled ones below
		vim.lsp.config("*", { capabilities = capabilities })

		-- cmd, filetypes and root_markers come from nvim-lspconfig's lsp/<name>.lua
		vim.lsp.config("dartls", {
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		})
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				-- Leave formatting to stylua
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})

		-- Servers to enable once their executable is available, e.g. zls from a project's nix shell.
		-- Rechecked on every FileType, so tools that appear on PATH later are found too.
		local servers = {
			lua_ls = "lua-language-server",
			stylua = "stylua",
			texlab = "texlab",
			clangd = "clangd",
			zls = "zls",
			rust_analyzer = "rust-analyzer",
			gopls = "gopls",
			dartls = "dart",
			-- ts_ls also picks up a project-local install from node_modules
			ts_ls = function(buf)
				return vim.fn.executable("typescript-language-server") == 1
					or #vim.fs.find("node_modules/.bin/typescript-language-server", {
							path = vim.fs.dirname(vim.api.nvim_buf_get_name(buf)),
							upward = true,
						})
						> 0
			end,
			basedpyright = "basedpyright-langserver",
		}
		local function enable_available(buf)
			for name, exe in pairs(servers) do
				if not vim.lsp.is_enabled(name) then
					local available
					if type(exe) == "function" then
						available = exe(buf)
					else
						available = vim.fn.executable(exe) == 1
					end
					if available then
						vim.lsp.enable(name)
					end
				end
			end
		end
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("lsp_auto_enable", { clear = true }),
			callback = function(args)
				enable_available(args.buf)
			end,
		})
		-- The plugin is lazy-loaded, so the buffer that triggered it may already have a filetype
		enable_available(vim.api.nvim_get_current_buf())

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
