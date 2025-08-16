return {
  {
    "mcauley-penney/techbase.nvim",
    opts = {
      italic_comments = true,

      -- set to true to make the background, floating windows, statusline,
      -- signcolumn, foldcolumn, and tabline transparent
      transparent = true,

      -- plugin_support = {
      --   aerial = false,
      --   blink = false,
      --   edgy = false,
      --   gitsigns = true,
      --   hl_match_area = false,
      --   lazy = true,
      --   lualine = true,
      --   mason = false,
      --   mini_cursorword = false,
      --   nvim_cmp = false,
      --   vim_illuminate = false,
      --   visual_whitespace = false,
      -- },

      -- allows you to override any highlight group for finer-grained control
      hl_overrides = {},
    },
    init = function() vim.cmd.colorscheme("techbase") end,
    priority = 1000
  },
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
        -- variant = "moon",
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
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
