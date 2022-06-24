local telescope = require('telescope')
local builtin = require("telescope.builtin")

telescope.setup()
telescope.load_extension('fzf')

local wk = require("which-key")
wk.register({
  ["<leader>f"] = { name = "+Find"},
  ["<leader>ff"] = { builtin.find_files, "Files" },
  ["<leader>fg"] = { builtin.live_grep, "Text (grep)"},
  ["<leader>fb"] = { builtin.buffers, "Buffers" },
  ["<leader>fr"] = { function() builtin.lsp_references({layout_strategy="vertical"}) end, "References (LSP)" },
  ["<leader>fd"] = { function() builtin.diagnostics({layout_strategy="vertical"}) end, "Diagnostics (LSP)" },
})

