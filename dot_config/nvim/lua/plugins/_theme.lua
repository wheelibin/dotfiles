return {

  {
    'EdenEast/nightfox.nvim',
    name = 'theme: nightfox',
    priority = 1000,
    config = function()
      -- vim.g.melange_enable_font_variants = 0
      vim.cmd('colorscheme nightfox')
    end
  },

  {
    'catppuccin/nvim',
    name = 'theme: catppuccin',
    priority = 1000,
    lazy = true,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'theme: kanagawa',
    priority = 1000,
    lazy = true,
  },
  {
    'savq/melange-nvim',
    name = 'theme: melange',
    priority = 1000,
    lazy = true,
  }

}
