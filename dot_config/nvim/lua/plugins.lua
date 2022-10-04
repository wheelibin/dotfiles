-- auto install the package manager on first use
local packer_installed = false
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_installed = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
end

return require('packer').startup(function(use)
  -- packer itself
  use 'wbthomason/packer.nvim'

  -- Speed up loading Lua modules in Neovim to improve startup time
  use {
    'lewis6991/impatient.nvim'
  }

  -- key mapping legend and discovery
  use {
    'mrjones2014/legendary.nvim',
    requires = { { 'stevearc/dressing.nvim' } },
    config = function()
      require('legendary').setup()
    end
  }

  -- themes
  -- use {
  --   'sainnhe/sonokai',
  --   config = function()
  --     vim.g.sonokai_style = 'atlantis'
  --     vim.g.sonokai_better_performance = 1
  --     vim.cmd('colorscheme sonokai')
  --   end
  -- }

  -- use {
  --   'sainnhe/everforest',
  --   rtp = 'vim' ,
  --   config = function()
  --     vim.cmd('colorscheme everforest')
  --   end
  -- }

  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require("catppuccin").setup()
      vim.cmd('colorscheme catppuccin')
    end
  }

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('config/nvim-tree')
    end
  }

  -- highlight cursor movement
  -- use 'DanilaMihailov/beacon.nvim'

  -- status bar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { { 'kyazdani42/nvim-web-devicons', opt = true }, { 'f-person/git-blame.nvim' } },
    config = function()
      require('config/lualine')
    end
  }

  -- find files (fuzzy search/grep)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim' },
      { 'fannheyward/telescope-coc.nvim' },
      { 'kkharji/sqlite.lua' }
    },
    config = function()
      require('config/telescope')
    end
  }

  -- -- some language configs for the built-in language server
  -- use {
  --   'neovim/nvim-lspconfig',
  --   requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'lvimuser/lsp-inlayhints.nvim' },
  --   config = function()
  --     require('config/lspconfig')
  --   end
  -- }
  --
  -- -- Autocompletion plugin
  -- use {
  --   'hrsh7th/nvim-cmp',
  --   requires = {
  --     'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-vsnip',
  --     'hrsh7th/vim-vsnip', 'hrsh7th/cmp-nvim-lsp-document-symbol', 'ray-x/lsp_signature.nvim',
  --     'rafamadriz/friendly-snippets'
  --   },
  --   config = function()
  --     require('config/nvim-cmp')
  --   end
  -- }

  -- better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('config/treesitter')
    end
  }

  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      require('config/coc')
    end
  }


  -- -- linting and more
  -- use {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   requires = { { 'nvim-lua/plenary.nvim' } },
  --   config = function()
  --     require('config/null-ls')
  --   end
  -- }

  -- fancy scrollbar with errors/warning markers
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  }

  use {
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config/neogit')
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup()
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('config/gitsigns')
    end
  }

  -- swiss army knife, see config to see which modules are enabled
  use {
    'echasnovski/mini.nvim',
    config = function()
      require('config/mini')
    end
  }

  use {
    'rcarriga/nvim-notify',
    config = function()
      require('config/nvim-notify')
    end
  }

  -- use {
  --   'windwp/nvim-autopairs',
  --   -- config = function()
  --   --   require('nvim-autopairs').setup {}
  --   -- end
  -- }

  use {
    'arkav/lualine-lsp-progress',
  }

  use {
    'ethanholz/nvim-lastplace'
  }

  -- -- Lua
  -- use {
  --   "folke/trouble.nvim",
  --   requires = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  use {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup()
    end
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_installed then
    require('packer').sync()
  end
end)
