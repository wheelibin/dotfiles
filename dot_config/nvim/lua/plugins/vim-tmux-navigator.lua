return {
  'christoomey/vim-tmux-navigator',
  config = function()
    local legendary = require('legendary')
    legendary.keymaps({
      { '<M-m>', ":TmuxNavigateLeft<cr>",  description = 'Goto window to the left' },
      { '<M-n>', ":TmuxNavigateDown<cr>",  description = 'Goto window below' },
      { '<M-e>', ":TmuxNavigateUp<cr>",    description = 'Goto window above' },
      { '<M-i>', ":TmuxNavigateRight<cr>", description = 'Goto window to the right' }
    })
  end
}
