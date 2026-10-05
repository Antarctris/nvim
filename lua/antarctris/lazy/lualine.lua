return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		-- Theme built from the terminal's ANSI color indices (0-15), so it follows alacritty
		local ansi = {
			normal = {
				a = { fg = 0, bg = 4, gui = "bold" },
				b = { fg = 7, bg = 8 },
				c = { fg = 7, bg = 0 },
			},
			insert = { a = { fg = 0, bg = 2, gui = "bold" } },
			visual = { a = { fg = 0, bg = 5, gui = "bold" } },
			replace = { a = { fg = 0, bg = 1, gui = "bold" } },
			command = { a = { fg = 0, bg = 3, gui = "bold" } },
			inactive = {
				a = { fg = 8, bg = 0 },
				b = { fg = 8, bg = 0 },
				c = { fg = 8, bg = 0 },
			},
		}

		-- Everything not set here uses lualine's defaults
		require("lualine").setup({
			options = {
				theme = ansi,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		})
	end,
}
