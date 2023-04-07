return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    vim.keymap.set('n', '<M-left>', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<M-down>', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<M-up>', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<M-right>', require('smart-splits').move_cursor_right)
  end
}
