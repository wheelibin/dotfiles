-- set up git blame to work with lualine
local git_blame = require('gitblame')
vim.g.gitblame_enable = 1
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%r'

-- if _G.Tabline_timer == nil then
--   _G.Tabline_timer = vim.loop.new_timer()
-- else
--   _G.Tabline_timer:stop()
-- end
-- _G.Tabline_timer:start(0,             -- never timeout
--                        1000,          -- repeat every 1000 ms
--                        vim.schedule_wrap(function() -- updater function
--                                             vim.api.nvim_command('redrawtabline')
--                                          end))

require('lualine').setup({
  options = {
    theme = 'nord'
  },
  sections = {
    lualine_c = {
      {
        git_blame.get_current_blame_text,
        cond = git_blame.is_blame_text_available,
      }
    },
    lualine_x = {'encoding', 'filetype'},
},
  tabline = {
    lualine_a = {
      {
        'filename',
        file_status = true,
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_z = {
      'buffers'
    }
  }
})
