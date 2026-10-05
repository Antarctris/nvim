vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Colors come from noctalia via matugen (lua/matugen.lua), which reapplies them on SIGUSR1.
-- base16-nvim does not fire ColorScheme, so do it here to let lualine etc. pick them up.
vim.api.nvim_create_autocmd("Signal", {
	pattern = "SIGUSR1",
	callback = function()
		-- Give matugen's own SIGUSR1 handler time to apply the new colors first
		vim.defer_fn(function()
			vim.api.nvim_exec_autocmds("ColorScheme", {})
		end, 100)
	end,
})

vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 32
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.colorcolumn = "92"

vim.opt.clipboard = "unnamedplus"
