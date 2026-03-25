return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		"debugloop/telescope-undo.nvim",
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

		local builtin = require("telescope.builtin")
		-- File pickers
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
		vim.keymap.set("n", "<C-b>", builtin.buffers, {})

		-- Undo
		vim.keymap.set("n", "<C-u>", "<cmd>Telescope undo<cr>")

		-- LSP
		vim.keymap.set("n", "gdb", function()
			builtin.diagnostics({ bufnr = 0 })
		end, {})
		vim.keymap.set("n", "gdm", builtin.diagnostics, {})
		vim.keymap.set("n", "grr", builtin.lsp_references)
		vim.keymap.set("n", "gdd", builtin.lsp_definitions)
		vim.keymap.set("n", "gdi", builtin.lsp_implementations)
		vim.keymap.set("n", "gdt", builtin.lsp_type_definitions)
		vim.keymap.set("n", "gds", builtin.lsp_document_symbols)
		vim.keymap.set("n", "gws", builtin.lsp_workspace_symbols)
		-- vim.keymap.set("n", "gdws", builtin.lsp_dynamic_workspace_symbols)

		-- Other
		vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
	end,
}
