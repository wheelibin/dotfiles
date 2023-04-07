return {
  'mrjones2014/legendary.nvim',
  dependencies = { { 'stevearc/dressing.nvim' } },
  config = function()
    require('legendary').setup()
  end
}
