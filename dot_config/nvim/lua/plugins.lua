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

  -- key mapping legend and discovery
  use {
    'mrjones2014/legendary.nvim',
    requires = { { 'stevearc/dressing.nvim' } },
    config = function()
      require('legendary').setup()
    end
  }

  -- theme
  use {
    'shaunsingh/nord.nvim',
    config = function()
      require('config/nord')
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
  use 'DanilaMihailov/beacon.nvim'

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
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } },
    config = function()
      require('config/telescope')
    end
  }

  -- some language configs for the built-in language server
  use {
    'williamboman/nvim-lsp-installer', {
      'neovim/nvim-lspconfig',
      config = function()
        require('config/lspconfig')
      end
    }
  }

  -- Autocompletion plugin
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- LSP source for nvim-cmp
      'hrsh7th/cmp-nvim-lsp', -- Snippets source for nvim-cmp
      'saadparwaiz1/cmp_luasnip', -- Snippets plugin
      'L3MON4D3/LuaSnip', 'rafamadriz/friendly-snippets'
    },
    config = function()
      require('config/nvim-cmp')
    end
  }

  -- better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('config/treesitter')
    end
  }

  -- linting and more
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('config/null-ls')
    end
  }

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

  use { 'ray-x/lsp_signature.nvim' }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  }

  use { 'mg979/vim-visual-multi' }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('config/toggleterm')
    end
  }

  use {
    'klen/nvim-test',
    config = function()
      require('config/nvim-test')
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup()
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end
  }

  -- swiss army knife, see config to see which modules are enabled
  use {
    'echasnovski/mini.nvim',
    config = function()
      require('config/mini')
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_installed then
    require('packer').sync()
  end
end)
