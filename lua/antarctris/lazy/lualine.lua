return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Load after the colorscheme, so the theme picks up its colors
	event = "VeryLazy",

	config = function()
		-- Everything not set here uses lualine's defaults
		require("lualine").setup({
			options = {
				theme = "base16", -- reads the palette from base16-nvim (set up by matugen)
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		})
	end,
}
