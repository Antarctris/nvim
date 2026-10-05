return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		lazy = true, -- loaded together with nvim-cmp in lsp.lua
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
			ls.filetype_extend("javascript", { "jsdoc" })

			-- Expand the snippet whose trigger word is right before the cursor.
			-- While the cmp menu is open, cmp's <C-e> (abort) takes precedence.
			vim.keymap.set({ "i" }, "<C-e>", function()
				ls.expand()
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
