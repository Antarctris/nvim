-- Git change markers in the sign column, plus hunk navigation, staging and blame
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local function map(mode, lhs, rhs)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
			end

			-- Same pattern as g[d / g]d for diagnostics
			map("n", "g[h", function()
				gitsigns.nav_hunk("prev")
			end)
			map("n", "g]h", function()
				gitsigns.nav_hunk("next")
			end)

			map("n", "ghp", gitsigns.preview_hunk)
			-- Staging an already staged hunk unstages it again
			map("n", "ghs", gitsigns.stage_hunk)
			map("n", "ghr", gitsigns.reset_hunk)
			map("v", "ghs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("v", "ghr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("n", "ghS", gitsigns.stage_buffer)
			map("n", "ghR", gitsigns.reset_buffer)

			map("n", "ghb", function()
				gitsigns.blame_line({ full = true })
			end)
			map("n", "ghB", gitsigns.toggle_current_line_blame)
			map("n", "ghd", gitsigns.diffthis)

			-- Hunk text object, e.g. dih or vih
			map({ "o", "x" }, "ih", gitsigns.select_hunk)
		end,
	},
}
