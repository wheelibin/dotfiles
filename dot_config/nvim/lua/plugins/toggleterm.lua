return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup {}

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    local legendary = require('legendary')
    -- local legendary_toolbox = require('legendary.toolbox')

    legendary.keymaps({
      {
        '<leader>lg',
        _lazygit_toggle,
        description = 'Toggle Lazygit'
      },

    })
  end
}
