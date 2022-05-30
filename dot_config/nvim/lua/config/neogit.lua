require('neogit').setup()

local map = vim.api.nvim_set_keymap
local options = { noremap = true }

map('n', '<Leader>g', '<cmd>lua require("neogit").open({ kind = "vsplit" })<cr>', options)
