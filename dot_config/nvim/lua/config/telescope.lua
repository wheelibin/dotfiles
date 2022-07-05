local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<M-x>"] = "delete_buffer",
        }
      }
    }
  }
}
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
  }, { '<leader>fs', builtin.lsp_dynamic_workspace_symbols, description = 'Find symbols (LSP)' },
  { '<leader>fh', builtin.git_bcommits, description = 'File History (git)' }
})
