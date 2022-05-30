local map = vim.api.nvim_set_keymap
local options = { noremap = true }

local telescope = require('telescope')
telescope.setup()
telescope.load_extension('fzf')

-- find shortcuts
map('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', options)
map('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', options)
map('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', options)
map('n', '<Leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', options)
