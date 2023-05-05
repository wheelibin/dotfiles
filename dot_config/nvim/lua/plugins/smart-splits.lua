return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    vim.keymap.set('n', '<M-m>', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<M-n>', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<M-e>', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<M-i>', require('smart-splits').move_cursor_right)
  end
}
