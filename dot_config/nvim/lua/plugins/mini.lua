return {
  'echasnovski/mini.nvim',
  config = function()
    local legendary = require('legendary')

    --
    -- enable individual modules
    --

    -- code commenting
    require('mini.comment').setup()
    legendary.keymaps({
      {
        'gc',
        description = 'Toggle comment (like `gcip` - comment inner paragraph)',
        mode = { 'n', 'v' }
      }, { 'gcc', description = 'Toggle comment on current line' }
    })

    -- highlight word under cursor
    -- _G.cursorword_blocklist = function()
    --   local curword = vim.fn.expand('<cword>')
    --   local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    --   -- Add any disabling global or filetype-specific logic here
    --   local blocklist = { '>' }
    --   if filetype == 'lua' then
    --     blocklist = { 'local', 'require' }
    --   elseif filetype == 'javascript' then
    --     blocklist = { 'import' }
    --   end
    --   vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
    -- end
    -- -- Make sure to add this autocommand *before* calling module's `setup()`.
    -- vim.cmd('au CursorMoved * lua _G.cursorword_blocklist()')
    require('mini.cursorword').setup({ delay = 400 })
    -- vim.cmd('hi! link MiniCursorword Visual')

    -- auto pairs (braces, quotes etc)
    require('mini.pairs').setup()

    -- remove buffers retaining window layout
    local miniBufRemove = require('mini.bufremove')
    miniBufRemove.setup()
    legendary.keymaps({
      { '<M-x>', miniBufRemove.delete, description = 'Delete Buffer' } --
    })

    -- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.).
    -- require('mini.surround').setup()
  end
}
