return {
  "tpope/vim-fugitive",
  config = function()
    local legendary = require('legendary')
    local legendary_toolbox = require('legendary.toolbox')

    legendary.keymaps({
      {
        '<leader>g', ":G<cr>", description = 'Test nearest'
      },
    })
  end
}
