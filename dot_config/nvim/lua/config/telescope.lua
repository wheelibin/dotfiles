local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup()
telescope.load_extension('fzf')

local legendary = require('legendary')
local helpers = require('legendary.helpers')

legendary.bind_keymaps({
  { '<leader>ff', builtin.find_files, description = 'Find files' },
  { '<leader>fg', builtin.live_grep, description = 'Find text (grep)' },
  { '<leader>fb', builtin.buffers, description = 'Find buffers' }, {
    '<leader>fr',
    helpers.lazy(builtin.lsp_references, { layout_strategy = 'vertical' }),
    description = 'Find references (LSP)'
  }, {
    '<leader>fd',
    helpers.lazy(builtin.diagnostics, { layout_strategy = 'vertical' }),
    description = 'Find diagnostics (LSP)'
  }
})
