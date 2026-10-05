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

-- Use the terminal's 16 ANSI colors so the colorscheme follows alacritty
vim.opt.termguicolors = false

vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 32
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.colorcolumn = "92"

vim.opt.clipboard = "unnamedplus"
