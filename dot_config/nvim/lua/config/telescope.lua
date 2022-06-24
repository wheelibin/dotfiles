local telescope = require('telescope')
local builtin = require("telescope.builtin")

telescope.setup()
telescope.load_extension('fzf')

local wk = require("which-key")
wk.register({
  ["<leader>f"] = { name = "+Find"},
  ["<leader>ff"] = { builtin.find_files, "Find Files" },
  ["<leader>fg"] = { builtin.live_grep, "Find Text (grep)"},
  ["<leader>fb"] = { builtin.buffers, "Find Buffers" },
  ["<leader>fr"] = { function() builtin.lsp_references({layout_strategy="vertical"}) end, "Find References (LSP)" },
  ["<leader>fd"] = { function() builtin.diagnostics({layout_strategy="vertical"}) end, "Find Diagnostics Items (LSP)" },
})

