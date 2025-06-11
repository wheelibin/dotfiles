return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = "BufEnter",
    dependencies = { 'f-person/git-blame.nvim' },
    config = function()
      -- set up git blame to work with lualine
      local git_blame = require('gitblame')
      vim.g.gitblame_enable = 1
      vim.g.gitblame_display_virtual_text = 0
      vim.g.gitblame_date_format = '%r'

      local config = {
        options = {
          theme = 'auto',
          disabled_filetypes = { 'neo-tree' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch', icon = '' },
            {
              'diff',
              diff_color = {
                -- Same color values as the general color option can be used here.
                added = 'GitSignsAdd',       -- Changes the diff's added color
                modified = 'GitSignsChange', -- Changes the diff's modified color
                removed = 'GitSignsDelete'   -- Changes the diff's removed color you
              }
            },
          },
          lualine_c = {
            {
              git_blame.get_current_blame_text,
              cond = git_blame.is_blame_text_available
            },
          },
          lualine_x = {
            { "aerial" },
            { 'filetype', 'filename' }
          }

        }
      }

      require('lualine').setup(config)
    end
  }
}
