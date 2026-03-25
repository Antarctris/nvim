-- Remove space, so it can be used for Alt-Space -> Esc
vim.keymap.set("n", "<Space>", "<Nop>")

-- Colemak improvement
vim.keymap.set({ "n", "v" }, "j", "h")
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "h", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Scroll remaps
vim.keymap.set({ "n", "v" }, "<C-h>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "")
vim.keymap.set({ "n", "v" }, "<C-d>", "")

-- Redo
vim.keymap.set("n", "<S-u>", vim.cmd.redo)

-- Removal of unused mappings
vim.keymap.set("n", "<C-r>", "")
vim.keymap.set("i", "<C-u>", "")
vim.keymap.set("i", "<C-h>", "")
vim.keymap.set("i", "<C-d>", "")
vim.keymap.set({ "n", "i" }, "<C-n>", "")
