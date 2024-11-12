return {
  {
    'petertriho/nvim-scrollbar',
    lazy = true,
    event = "BufEnter",
    config = function()
      require('scrollbar').setup()
    end
  }
}
