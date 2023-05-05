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
      close_if_last_window = false,
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
