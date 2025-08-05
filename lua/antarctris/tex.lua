vim.api.nvim_create_augroup("tex_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "tex_settings",
  pattern = "tex",
  callback = function()
    vim.opt_local.sidescrolloff = 0
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakat = " "
  end,
})
