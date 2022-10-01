-- set up git blame to work with lualine
local git_blame = require('gitblame')
vim.g.gitblame_enable = 1
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%r'


local config = {
  options = { 
    theme = 'auto',
    refresh = {
      tabline = 500,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', { 'diagnostics', colored = false } },
    lualine_c = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_z = {
      {
        'filename',
        file_status = true,
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    -- lualine_z = { 'buffers' }
  },
  extensions = { 'nvim-tree' }
}

local lsp_progress_comp = {
  'lsp_progress',
  -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
  -- With spinner
  display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage' } },
  -- colors = {
  --   percentage      = colors.cyan,
  --   title           = colors.cyan,
  --   message         = colors.cyan,
  --   spinner         = colors.cyan,
  --   lsp_client_name = colors.magenta,
  --   use             = true,
  -- },
  separators = {
    -- component = ' ',
    -- progress = ' | ',
    message = { pre = '(', post = ')', commenced = '', completed = 'Done' },
    -- percentage = { pre = '', post = '%% ' },
    -- title = { pre = '', post = ': ' },
    -- lsp_client_name = { pre = '[', post = ']' },
    -- spinner = { pre = '', post = '' },
  },
  timer = { progress_enddelay = 10, spinner = 500, lsp_client_name_enddelay = 10 },
  -- spinner_symbols = { '◐', '◓', '◑', '◒' }
  spinner_symbols = { '◡◡', '⊙⊙', '◠◠', '◡◡', '⊙⊙', '◠◠' },
  color= 'Todo'
}
table.insert(config.tabline.lualine_a, lsp_progress_comp)

require('lualine').setup(config)
