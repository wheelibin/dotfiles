require("trouble").setup()

local map = vim.api.nvim_set_keymap
local options = { noremap = true }


map('n', '<Leader>e', [[:TroubleToggle<cr>]], options)
