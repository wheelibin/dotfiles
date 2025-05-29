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


local function debounce(fn, delay)
  local timer = vim.loop.new_timer()
  local running = false
  return function(...)
    local args = { ... }
    if running then timer:stop() end
    timer:start(delay, 0, function()
      running = false
      vim.schedule(function() fn(unpack(args)) end)
    end)
    running = true
  end
end

local save_after_delay = debounce(function()
  vim.cmd("silent! update")
end, 3000)

vim.api.nvim_create_autocmd(
  { "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
  {
    pattern = "*",
    callback = save_after_delay
  })
