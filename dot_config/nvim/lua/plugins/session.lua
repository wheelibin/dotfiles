return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
    -- restore the session for the current directory

  },
  config = function()
    local legendary = require('legendary')
    legendary.keymap({
      '<leader>qs',
      [[<cmd>lua require("persistence").load()<cr>]],
      description = 'Load session for cwd'
    })
  end
}
