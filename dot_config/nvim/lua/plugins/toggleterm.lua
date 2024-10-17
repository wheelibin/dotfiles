return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    keys = {
      {
        "<leader>lg",
        mode = "n",
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" }):toggle()
        end
      },
      {
        "<leader>el",
        mode = "n",
        function()
          local trim_spaces = true
          require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
        end
      }
    },
    opts = {}
  }
}
