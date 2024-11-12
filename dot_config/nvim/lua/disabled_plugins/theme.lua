return {
  {
    'EdenEast/nightfox.nvim',
    name = 'theme: nightfox',
    priority = 1000,
    config = function()
      -- vim.g.melange_enable_font_variants = 0
      vim.cmd('colorscheme duskfox')
    end
  }
}
