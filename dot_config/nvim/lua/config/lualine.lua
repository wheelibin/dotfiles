-- set up git blame to work with lualine
local git_blame = require('gitblame')
vim.g.gitblame_enable = 1
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%r'

require('lualine').setup({
  options = { theme = 'nord' },
  sections = {
    lualine_c = {
      {
        git_blame.get_current_blame_text,
        cond = git_blame.is_blame_text_available
      }
    },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = {}
    -- lualine_z = { 'lsp_progress' }
  },
  tabline = {
    lualine_a = {
      {
        'filename',
        file_status = true,
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_z = { 'buffers' }
  },
  extensions = { 'nvim-tree', 'toggleterm' }
})
