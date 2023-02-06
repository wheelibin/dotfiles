local legendary = require('legendary')
local toolbox = require('legendary.toolbox')
local legendary_filters = require('legendary.filters')

legendary.keymaps({
  { '<F2>', toolbox.lazy(legendary.find, { filters = { legendary_filters.current_mode() } }),
    description = 'Show Legendary' },

  -- buffer switching
  { '<Leader>bf', [[:bn<cr>]], description = 'Buffer forward' },
  { '<Leader>bb', [[:bp<cr>]], description = 'Buffer back' }, 
  { '<bs>', '<C-^>', description = 'Edit alternative file' },
  -- window navigation
  { '<M-left>', ':wincmd h<CR>', description = 'Goto window to the left' },
  { '<M-down>', ':wincmd j<CR>', description = 'Goto window below' },
  { '<M-up>', ':wincmd k<CR>', description = 'Goto window above' },
  { '<M-right>', ':wincmd l<CR>', description = 'Goto window to the right' },
  { '<M-r>', ':wincmd r<CR>', description = 'Cycle through all windows' },
  { '<M-q>', ':wincmd q<CR>', description = 'Close current window' }, --
  -- window creation
  { '<M-S-left>', ':wincmd v<CR>:wincmd h<CR>', description = 'New window to the right' },
  { '<M-S-down>', ':wincmd s<CR>', description = 'New window below' },
  { '<M-S-up>', ':wincmd s<CR>:wincmd k<CR>', description = 'New window above' },
  { '<M-S-right>', ':wincmd v<CR>', description = 'New window to the left' }, --
  -- window resizing
  { '<C-M-S-j>', ':resize +2<CR>', description = 'Resize window - shorter' },
  { '<C-M-S-k>', ':resize -2<CR>', description = 'Resize window - taller' },
  { '<C-M-S-l>', ':vertical resize +2<CR>', description = 'Resize window - wider' },
  { '<C-M-S-h>', ':vertical resize -2<CR>', description = 'Resize window - narrower' }, --
  -- copy/paste system clipboard
  { '<Leader>y', '"+y', mode = 'v', description = 'Copy to system clipboard' },
  { '<Leader>p', '"+p', description = 'Paste from system clipboard' },
  { '<Leader>P', '"+P', description = 'Paste from system clipboard (before)' }, --
  -- move lines
  { '<C-up>', { n = ':m .-2<CR>==', i = '<Esc>:m .-2<CR>==gi', v = ':m \'<-2<CR>gv=gv' }, description = 'Move line up' },
  { '<C-down>', { n = ':m .+1<CR>==', i = '<Esc>:m .+1<CR>==gi', v = ':m \'>+1<CR>gv=gv' }, description = 'Move line down' },

  { '<leader><leader>', ':noh<CR>', description = 'Clear search highlighting' },

  { ';', ':', modes = {'n', 'v'}, options = { noremap = true } },
  { ':', ';', modes = {'n', 'v'}, options = { noremap = true } },

})

