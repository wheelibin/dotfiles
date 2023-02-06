local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

vim.g.coq_settings = {
        auto_start = true,
        display = {
          preview = {
            border = 'single',
            positions = { north = 2, south = 3, west = 4, east = 1 }
          }
        }
      }

      -- remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
      -- remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
      -- remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
      -- remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
      
      -- skip it, if you use another global object
      vim.g.MUtils= {}

      vim.g.MUtils.CR = function()
        if vim.fn.pumvisible() ~= 0 then
          if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
            return npairs.esc('<c-y>')
          else
            return npairs.esc('<c-e>') .. npairs.autopairs_cr()
          end
        else
          return npairs.autopairs_cr()
        end
      end
      remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
      
      vim.g.MUtils.BS = function()
        if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
          return npairs.esc('<c-e>') .. npairs.autopairs_bs()
        else
          return npairs.autopairs_bs()
        end
      end
      remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

