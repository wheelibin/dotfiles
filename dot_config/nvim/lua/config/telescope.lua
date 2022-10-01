local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- just close immediately on ESC rather than going to normal mode in the input
        ["<esc>"] = actions.close
      },
    },
    layout_config = {
      -- vertical = { width = 0.5 }
      -- other layout configuration here
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          -- close the selected buffer directly from the picker
          ["<M-x>"] = "delete_buffer",
        }
      }
    },
    find_files = {
      hidden = true
    },
    live_grep = {
      mappings = {
        i = {
          ["<M-r>"] = function(bufnr)
            local action_state = require "telescope.actions.state"
            local find_string = action_state.get_current_line()
            find_string = find_string:gsub('%/', '\\/')
            vim.ui.input({ prompt = "Replace string " .. find_string }, function(replace_string)
              replace_string = replace_string:gsub('%/', '\\/')
              actions.send_selected_to_qflist(bufnr)
              actions.open_qflist(bufnr)
              vim.cmd('cdo s/' .. find_string .. '/' .. replace_string .. '/gc')
            end)
          end
        }
      }
    }
  }
}

telescope.load_extension('fzf')
telescope.load_extension('frecency')

local legendary = require('legendary')
local helpers = require('legendary.helpers')

legendary.bind_keymaps({
  { '<leader>ff', builtin.find_files, description = 'Find files' },
  { '<leader>fg', builtin.live_grep, description = 'Find text (grep)' },
  { '<leader>fb', builtin.buffers, description = 'Find buffers' },
  { '<leader>fr', helpers.lazy(builtin.lsp_references, { layout_strategy = 'vertical' }),
    description = 'Find references (LSP)' },
  { '<leader>fe', helpers.lazy(builtin.diagnostics, { layout_strategy = 'vertical' }),
    description = 'Find errors (diagnostics) (LSP)' },
  { '<leader>fs', builtin.lsp_dynamic_workspace_symbols, description = 'Find symbols (LSP)' },
  { '<leader>fi', builtin.lsp_implementations, description = 'Find implementation(s) (LSP)' },
  { '<leader>fd', builtin.lsp_definitions, description = 'Find definition(s) (LSP)' },
  { '<leader>fh', builtin.git_bcommits, description = 'File History (git)' },
  { '<leader>fw', helpers.lazy(builtin.grep_string, { word_match = '-w' }), description = 'Find word under cursor' },
  { '<leader>tr', builtin.resume, description = 'Telescope Resume'}
})
