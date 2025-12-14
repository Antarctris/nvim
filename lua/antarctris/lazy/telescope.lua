return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
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
		})

		-- TODO: More config, especially key mappings here
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
		vim.keymap.set("n", "<C-b>", builtin.buffers, {})
		vim.keymap.set("n", "<C-d>", function()
			builtin.diagnostics({ bufnr = 0 })
		end, {})
		vim.keymap.set("n", "<C-S-d>", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
	end,
}
