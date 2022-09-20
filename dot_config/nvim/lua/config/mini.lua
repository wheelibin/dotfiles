local legendary = require('legendary')

--
-- enable individual modules
--

-- code commenting
require('mini.comment').setup()
legendary.bind_keymaps({
  {
    'gc',
    description = 'Toggle comment (like `gcip` - comment inner paragraph)',
    mode = { 'n', 'v' }
  }, { 'gcc', description = 'Toggle comment on current line' }
})

-- highlight word under cursor
require('mini.cursorword').setup({ delay = 400 })
-- vim.cmd('hi! link MiniCursorword Visual')

-- auto pairs (braces, quotes etc)
-- require('mini.pairs').setup()

-- remove buffers retaining window layout
local miniBufRemove = require('mini.bufremove')
miniBufRemove.setup()
legendary.bind_keymaps({
  { '<M-x>', miniBufRemove.delete, description = 'Delete Buffer' } --
})

-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.).
require('mini.surround').setup()
