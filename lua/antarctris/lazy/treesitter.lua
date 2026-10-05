return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		-- Requires the `tree-sitter` CLI and a C compiler.
		-- Runs asynchronously and is a no-op for parsers that are already installed.
		-- latex is left out on purpose.
		require("nvim-treesitter").install({
			"vimdoc",
			"vim",
			"lua",
			"go",
			"rust",
			"c",
			"cpp",
			"java",
			"javascript",
			"typescript",
			"jsdoc",
			"json",
			"bash",
			"dart",
			"markdown",
			"markdown_inline",
		})

		-- Highlighting and indentation are no longer enabled by the plugin itself
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function(args)
				-- Fails silently for filetypes without an installed parser
				if not pcall(vim.treesitter.start, args.buf) then
					return
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				-- Keep regex highlighting alongside treesitter for markdown
				if args.match == "markdown" then
					vim.bo[args.buf].syntax = "ON"
				end
			end,
		})
	end,
}
