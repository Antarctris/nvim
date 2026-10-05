-- Makes lua_ls aware of the Neovim API and installed plugins while editing this config
return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- Load luv types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
