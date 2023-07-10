return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup {
      search = {
        pattern = [[\b(KEYWORDS)(:|\s)]]
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
    }
  end
}
