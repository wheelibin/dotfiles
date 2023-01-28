-- set up git blame to work with lualine
local git_blame = require('gitblame')
vim.g.gitblame_enable = 1
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%r'

local function get_current_dir()
  return '📂 ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function format_filename(str)
  return '📄 ' .. str
end

local config = {
  options = {
    theme = 'auto',
    refresh = {
      tabline = 500,
    },
    -- globalstatus = true
  },
  sections = {
    lualine_a = { 'mode' },
    -- lualine_b = { 'branch', 'diff', { 'diagnostics', colored = false } },
    lualine_b = {
      'branch',
      {
        'diff',
        diff_color = {
          -- Same color values as the general color option can be used here.
          added    = 'GitSignsAdd', -- Changes the diff's added color
          modified = 'GitSignsChange', -- Changes the diff's modified color
          removed  = 'GitSignsDelete', -- Changes the diff's removed color you
        }
      }
    },
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
    lualine_a = { get_current_dir },
    lualine_z = {
      {
        'filename',
        file_status = true,
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        fmt = format_filename
      }
    },
    -- lualine_z = { 'buffers' }
  },
  extensions = { 'nvim-tree' }
}

require('lualine').setup(config)
