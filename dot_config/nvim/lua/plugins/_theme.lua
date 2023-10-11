return {

  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      -- vim.g.melange_enable_font_variants = 0
      vim.cmd('colorscheme nordfox')
    end
  },

  {
    'catppuccin/nvim',
    priority = 1000,
    lazy = true,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = true,
  },
  {
    'savq/melange-nvim',
    priority = 1000,
    lazy = true,
  }

}
