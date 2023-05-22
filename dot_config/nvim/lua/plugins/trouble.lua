local legendary = require('legendary')
return {
  'folke/trouble.nvim',
  config = function()
    require("trouble").setup {
      -- auto_open = true,
      -- auto_close = true,
    }
    legendary.keymaps({
      {
        '<leader>t', "<cmd>TroubleToggle workspace_diagnostics<cr>", description = 'Toggle Trouble'
      },
    })
  end
}
