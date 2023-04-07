return {
  'rcarriga/nvim-notify',
  config = function()
    vim.notify = require("notify")
    local stages_util = require("notify.stages.util")


    -- all this setup is to force notifications into the bottom right, todo: clean this up
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

    -- vim.api.nvim_create_autocmd({ 'UIEnter' }, {
    --   once = true,
    --   callback = function()
    --     local Spinner = require('config/nvim-notify-spinner')
    --     local spinners = {}
    --
    --     local function format_msg(msg, percentage)
    --       msg = msg or ''
    --       if not percentage then
    --         return msg
    --       end
    --       return string.format('%2d%%\t%s', percentage, msg)
    --     end
    --
    --     vim.api.nvim_create_autocmd({ 'User' }, {
    --       pattern = { 'LspProgressUpdate' },
    --       group = vim.api.nvim_create_augroup('LSPNotify', { clear = true }),
    --       desc = 'LSP progress notifications',
    --       callback = function()
    --         for _, c in ipairs(vim.lsp.get_active_clients()) do
    --           for token, ctx in pairs(c.messages.progress) do
    --             if not spinners[c.id] then
    --               spinners[c.id] = {}
    --             end
    --             local s = spinners[c.id][token]
    --             if not ctx.done then
    --               if not s then
    --                 spinners[c.id][token] = Spinner(
    --                   format_msg(ctx.message, ctx.percentage), vim.log.levels.INFO, {
    --                     title = ctx.title and string.format('%s: %s', c.name, ctx.title) or c.name
    --                   })
    --               else
    --                 s:update(format_msg(ctx.message, ctx.percentage))
    --               end
    --             else
    --               c.messages.progress[token] = nil
    --               if s then
    --                 s:done(ctx.message or 'Complete', nil, {
    --                   icon = '',
    --                 })
    --                 spinners[c.id][token] = nil
    --               end
    --             end
    --           end
    --         end
    --       end,
    --     })
    --   end,
    -- })
  end
}
