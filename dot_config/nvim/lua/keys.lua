local map = vim.api.nvim_set_keymap
local options = { noremap = true }

-- easier buffer switching
map('n', '<Leader>bf', [[:bn<cr>]], options)
map('n', '<Leader>bb', [[:bp<cr>]], options)

