local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function delete_others(bufnr)
  local current_picker = action_state.get_current_picker(bufnr)

  local selected = current_picker:get_selection_row()
  -- select all buffers
  actions.select_all(bufnr)
  -- deselect the current row
  current_picker:toggle_selection(selected)
  -- delete selected buffers
  actions.delete_buffer(bufnr)
end

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
          -- close all buffers except the currently highlighted row
          ["<M-X>"] = delete_others,
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
            local find_string = action_state.get_current_line()
            vim.ui.input({ prompt = "Replace string " .. find_string }, function(replace_string)
              actions.send_selected_to_qflist(bufnr)
              actions.open_qflist(bufnr)
              vim.cmd('cdo s%' .. find_string .. '%' .. replace_string .. '%gc')
            end)
          end
        }
      }
    }
  }
}

telescope.load_extension('fzf')
pcall(function()
  telescope.load_extension('frecency')
end)
telescope.load_extension('coc')

local legendary = require('legendary')
local helpers = require('legendary.helpers')

legendary.bind_keymaps({
  { '<leader>ff', helpers.lazy(builtin.find_files, { path_display = { 'truncate' } }), description = 'Find files' },
  { '<leader>fg', builtin.live_grep, description = 'Find text (grep)' },
  { '<leader>fb', helpers.lazy(builtin.buffers, { path_display = { 'truncate' } }), description = 'Find buffers' },
  { '<leader>fr', ':Telescope coc references path_display={"tail"}<cr>', description = 'Find references (LSP)' },
  { '<leader>fe', ':Telescope coc workspace_diagnostics<cr>', description = 'Find errors (diagnostics) (LSP)' },
  { '<leader>fs', ':Telescope coc workspace_symbols<cr>', description = 'Find symbols (LSP)' },
  { '<leader>fi', builtin.lsp_implementations, description = 'Find implementation(s) (LSP)' },
  { '<leader>fd', ':Telescope coc definitions<cr>', description = 'Find definition(s) (LSP)' },
  { '<leader>fh', builtin.git_bcommits, description = 'File History (git)' },
  { '<leader>fw', helpers.lazy(builtin.grep_string, { word_match = '-w' }), description = 'Find word under cursor' },
  { '<leader>tr', builtin.resume, description = 'Telescope Resume' }
})
