-- Remove space, so it can be used for Alt-Space -> Esc
vim.keymap.set("n", "<Space>", "<Nop>")

-- Colemak improvement
vim.keymap.set({ "n", "v" }, "j", "h")
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "h", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Scroll remaps (scrolloff = 999 already keeps the cursor centered)
vim.keymap.set({ "n", "v" }, "<C-h>", "<C-u>")
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-d>")
-- Normal mode <C-u> is Telescope undo
vim.keymap.set("v", "<C-u>", "<Nop>")
vim.keymap.set({ "n", "v" }, "<C-d>", "<Nop>")

-- Redo
vim.keymap.set("n", "<S-u>", vim.cmd.redo)

-- Removal of unused mappings
vim.keymap.set("n", "<C-r>", "<Nop>")
vim.keymap.set("i", "<C-d>", "<Nop>")

-- nvim-cmp only handles these while its menu is open. Otherwise it falls back to
-- whatever the key is mapped to, which would be the Neovim default without these.
-- Insert-mode <C-h> is additionally mapped to LuaSnip's change_choice in snippets.lua.
vim.keymap.set("i", "<C-h>", "<Nop>") -- default: backspace
vim.keymap.set("i", "<C-k>", "<Nop>") -- default: enter a digraph
vim.keymap.set("i", "<C-u>", "<Nop>") -- default: delete text before the cursor
vim.keymap.set({ "n", "i" }, "<C-n>", "<Nop>")
