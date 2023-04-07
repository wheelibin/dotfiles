return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'f-person/git-blame.nvim' }, { 'arkav/lualine-lsp-progress' }
  },
  config = function()
    -- set up git blame to work with lualine
    local git_blame = require('gitblame')
    vim.g.gitblame_enable = 1
    vim.g.gitblame_display_virtual_text = 0
    vim.g.gitblame_date_format = '%r'


    -- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#changing-filename-color-based-on--modified-status
    local custom_fname = require('lualine.components.filename'):extend()
    local highlight = require 'lualine.highlight'
    local default_status_colors = { saved = '#292522', modified = '#422741' }

    function custom_fname:init(options)
      custom_fname.super.init(self, options)
      self.status_colors = {
        saved = highlight.create_component_highlight_group(
          { bg = '#292522' }, 'filename_status_saved', self.options),
        modified = highlight.create_component_highlight_group(
          { bg = '#8B7449', fg = '#292522' }, 'filename_status_modified', self.options),
      }
      if self.options.color == nil then self.options.color = '' end
    end

    function custom_fname:update_status()
      local data = custom_fname.super.update_status(self)
      data = highlight.component_format_highlight(vim.bo.modified
            and self.status_colors.modified
            or self.status_colors.saved) .. data
      return data
    end

    -- --------

    local config = {
      options = {
        theme = 'auto',
        -- refresh = { tabline = 500 }
        -- globalstatus = true
      },
      sections = {
        lualine_a = { 'mode' },
        -- lualine_b = { 'branch', 'diff', { 'diagnostics', colored = false } },
        lualine_b = {
          { 'FugitiveHead', icon = '' }, {
          'diff',
          diff_color = {
            -- Same color values as the general color option can be used here.
            added = 'GitSignsAdd',       -- Changes the diff's added color
            modified = 'GitSignsChange', -- Changes the diff's modified color
            removed = 'GitSignsDelete'   -- Changes the diff's removed color you
          }
        }
        },
        lualine_c = {
          {
            git_blame.get_current_blame_text,
            cond = git_blame.is_blame_text_available
          }
        },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = {}
      },
      inactive_sections = {
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {
        --   {
        --     'filename',
        --     file_status = true,
        --     path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
        --   }
        -- },
        -- lualine_x = { 'encoding', 'filetype' },
        -- lualine_y = {},
        -- lualine_z = {}
      },
      tabline = {
        -- lualine_a = { get_current_dir },
        lualine_z = {
          {
            custom_fname,
            file_status = true,
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            -- fmt = format_filename
          }
        }
        -- lualine_z = { 'buffers' }
      },
      extensions = {}
    }

    require('lualine').setup(config)
  end
}
