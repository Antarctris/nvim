-- Colemak improvement
vim.keymap.set('n', 'j', 'h')
vim.keymap.set('n', 'k', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'h', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


