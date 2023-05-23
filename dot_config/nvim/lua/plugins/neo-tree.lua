return
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  config = function()
    local legendary = require('legendary')
    legendary.keymap({
      '<leader>n',
      [[:Neotree source=filesystem reveal=true position=left toggle=true<cr>]],
      description = 'Nvim-Tree Toggle'
    })

    require("neo-tree").setup({
      -- source_selector = {
      --   winbar = true,
      -- },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added     = "",  -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "",  -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖", -- this can only be used in the git_status source
            renamed   = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "?",
            ignored   = "",
            unstaged  = "u",
            staged    = "s",
            conflict  = "",
          }
        },
      },
      filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      buffers = {
        follow_current_file = true
      },
      window = {
        mappings = {
          -- remap (m)ove to (mv)ove
          ["m"] = "none",
          ["mv"] = "move",
          -- remove "e"
          ["e"] = "none"
        }
      }
    })
  end
}
