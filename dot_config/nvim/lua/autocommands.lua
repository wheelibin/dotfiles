-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- set custom file highlighting
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "Tiltfile", command = [[set filetype=python]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "Dockerfile*", command = [[set filetype=dockerfile]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*.gql.tmpl", command = [[set filetype=graphql]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*.http", command = [[set filetype=http]] })


-- -- Run goimport on save
-- local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*.go",
--   command = [[%!goimports %]],
--   group = format_sync_grp,
-- })
