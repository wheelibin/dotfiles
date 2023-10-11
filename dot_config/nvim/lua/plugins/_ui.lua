return {
  -- {
  --   "startup-nvim/startup.nvim",
  --   requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require "startup".setup()
  --   end
  -- },
  {
    'petertriho/nvim-scrollbar',
    lazy = true,
    event = "BufEnter",
    config = function()
      require('scrollbar').setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = "BufEnter",
    dependencies = { 'f-person/git-blame.nvim', 'arkav/lualine-lsp-progress' },
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
        }
      }

      require('lualine').setup(config)
    end
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
      local stages_util = require("notify.stages.util")

      -- TODO: all this setup is to force notifications into the bottom right, clean this up
      require("notify").setup({
        stages = {
          function(state)
            local next_height = state.message.height + 2
            local next_row = stages_util.available_slot(
              state.open_windows,
              next_height,
              stages_util.DIRECTION.BOTTOM_UP
            )
            if not next_row then
              return nil
            end
            return {
              relative = "editor",
              anchor = "NE",
              width = state.message.width,
              height = state.message.height,
              col = vim.opt.columns:get(),
              row = next_row,
              border = "rounded",
              style = "minimal",
              opacity = 0,
            }
          end,
          function()
            return {
              opacity = { 100 },
              col = { vim.opt.columns:get() },
            }
          end,
          function()
            return {
              col = { vim.opt.columns:get() },
              time = true,
            }
          end,
          function()
            return {
              width = {
                1,
                frequency = 2.5,
                damping = 0.9,
                complete = function(cur_width)
                  return cur_width < 3
                end,
              },
              opacity = {
                0,
                frequency = 2,
                complete = function(cur_opacity)
                  return cur_opacity <= 4
                end,
              },
              col = { vim.opt.columns:get() },
            }
          end,
        },
      })
    end
  }


}
