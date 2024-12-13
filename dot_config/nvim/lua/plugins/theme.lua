return {
  {
    'rebelot/kanagawa.nvim',
    config = function()
      -- vim.cmd.colorscheme('kanagawa-dragon')
    end
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'theme: nightfox',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme duskfox')
    end
  },
  {
    "rose-pine/neovim",
    name = "theme: rose-pine",
    config = function()
      require("rose-pine").setup({ variant = "moon" })
      -- vim.cmd('colorscheme rose-pine')
    end
  },
  {
    'sainnhe/gruvbox-material',
    name = "theme: gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      -- vim.g.gruvbox_material_enable_italic = true
      -- vim.g.gruvbox_material_foreground = 'mix'
      -- vim.g.gruvbox_material_enable_bold = true

      -- vim.g.gruvbox_material_background = 'hard'
      -- vim.g.gruvbox_material_better_performance = 1
      -- vim.cmd.colorscheme('gruvbox-material')
    end
  },
  {
    "catppuccin/nvim",
    name = "theme: catppuccin",
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme catppuccin')
    end
  }
}
