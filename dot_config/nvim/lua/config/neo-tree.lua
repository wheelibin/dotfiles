local legendary = require('legendary')
legendary.keymap({
  '<leader>n',
  [[:Neotree source=filesystem reveal=true position=left toggle=true<cr>]],
  description = 'Nvim-Tree Toggle'
})
