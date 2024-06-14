return {

  {
    'EdenEast/nightfox.nvim',
    name = 'theme: nightfox',
    priority = 1000,
    config = function()
      -- vim.g.melange_enable_font_variants = 0
      -- vim.cmd('colorscheme nordfox')
    end
  },

  {
    'catppuccin/nvim',
    name = 'theme: catppuccin',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme catppuccin-macchiato')
    end
    -- lazy = true,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'theme: kanagawa',
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme kanagawa')
    end
  },
  {
    'savq/melange-nvim',
    name = 'theme: melange',
    priority = 1000,
    -- lazy = true,
  },
  {
    'wuelnerdotexe/vim-enfocado',
    name = 'theme: enfocado',
    priority = 1000,
    config = function()
      vim.g.enfocado_style = 'neon'
    end
  },
  {
    'sainnhe/everforest',
    name = 'theme: everforest',
    priority = 1000,
    config = function()
      -- vim.cmd('set background=light')
      -- " Set contrast.
      -- " This configuration option should be placed before `colorscheme everforest`.
      -- " Available values: 'hard', 'medium'(default), 'soft'
      vim.g.everforest_background = 'hard'

      -- " For better performance
      vim.g.everforest_better_performance = 1

      -- vim.cmd('colorscheme everforest')
    end
  },
  {
    'rose-pine/neovim',
    name = 'theme: rose-pine',
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme rose-pine-moon')
    end
  },
  {
    'sainnhe/gruvbox-material',
    name = 'theme: gruvbox-material',
    priority = 1000,
    config = function()
    end
  },
  {
    'Mofiqul/vscode.nvim',
    name = 'theme: vscode',
    priority = 1000,
    config = function()
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- vim.cmd('colorscheme tokyonight')
    end
  }
}
