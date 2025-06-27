return {
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({
        theme = 'wave',
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        }
      })
      -- vim.cmd.colorscheme('kanagawa')
    end
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'theme: nightfox',
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true
        }
      })
      -- vim.cmd('colorscheme duskfox')
    end
  },
  {
    "rose-pine/neovim",
    name = "theme: rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
      vim.cmd('colorscheme rose-pine')
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
