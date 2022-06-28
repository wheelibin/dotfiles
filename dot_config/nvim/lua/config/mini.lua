require('mini.comment').setup()

require('mini.cursorword').setup({ delay = 400 })
vim.cmd('hi! link MiniCursorword Visual')

require('mini.pairs').setup()

require('mini.bufremove').setup()
