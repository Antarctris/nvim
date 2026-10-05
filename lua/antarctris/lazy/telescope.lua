return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
	},
	cmd = "Telescope",
	-- Loads telescope on the first use of one of these keys
	keys = {
		-- File pickers
		{ "<C-p>", "<cmd>Telescope find_files<cr>" },
		{ "<C-f>", "<cmd>Telescope live_grep<cr>" },
		{ "<C-b>", "<cmd>Telescope buffers<cr>" },

		-- Undo
		{ "<C-u>", "<cmd>Telescope undo<cr>" },

		-- LSP
		{ "gdb", "<cmd>Telescope diagnostics bufnr=0<cr>" },
		{ "gdm", "<cmd>Telescope diagnostics<cr>" },
		{ "grr", "<cmd>Telescope lsp_references<cr>" },
		{ "gdd", "<cmd>Telescope lsp_definitions<cr>" },
		{ "gdi", "<cmd>Telescope lsp_implementations<cr>" },
		{ "gdt", "<cmd>Telescope lsp_type_definitions<cr>" },
		{ "gds", "<cmd>Telescope lsp_document_symbols<cr>" },
		{ "gws", "<cmd>Telescope lsp_workspace_symbols<cr>" },
		-- { "gdws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },

		-- Other
		{ "<leader>th", "<cmd>Telescope help_tags<cr>" },
	},

	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						-- C-c also is a direct close, but Esc is more intuitive
						["<Esc>"] = require("telescope.actions").close,
					},
				},
			},
			extensions = {
				undo = {
					-- telescope-undo.nvim config
					-- Note that applying an undo state, needs to used Ctrl-Enter!
				},
			},
		})
		require("telescope").load_extension("undo")
	end,
}
