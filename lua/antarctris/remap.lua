-- Colemak improvement
vim.keymap.set('n', 'j', 'h')
vim.keymap.set('n', 'k', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'h', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Scroll remaps
vim.keymap.set('n', "<C-h>", "<C-u>zz")
vim.keymap.set('n', "<C-k>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "")
vim.keymap.set('n', "<C-d>", "")

-- Removal of unused mappings for use with plugins
vim.keymap.set('i', "<C-u>", "")
vim.keymap.set('i', "<C-h>", "")
vim.keymap.set({'n', 'i'}, "<C-n>", "")

