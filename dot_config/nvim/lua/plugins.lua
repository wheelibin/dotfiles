-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local plugins = {

  {
    'mrjones2014/legendary.nvim',
    dependencies = { { 'stevearc/dressing.nvim' } },
    config = function() require('legendary').setup() end
  }, {
    'savq/melange-nvim',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd('colorscheme melange')
    end
  }, {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = function() require('config/neo-tree') end
  }, {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'f-person/git-blame.nvim' }, { 'arkav/lualine-lsp-progress' }
    },
    config = function() require('config/lualine') end
  }, {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim' }, { 'kkharji/sqlite.lua' }
    },
    config = function() require('config/telescope') end
  }, {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
      'lvimuser/lsp-inlayhints.nvim', 'jose-elias-alvarez/typescript.nvim'
    },
    config = function() require('config/lspconfig') end
  }, {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    dependencies = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } },
    config = function()
      vim.g.coq_settings = {
        auto_start = true,
        display = {
          preview = {
            border = 'single',
            positions = { north = 2, south = 3, west = 4, east = 1 }
          }
        }
      }
    end
  }, {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('config/null-ls') end
  }, {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function() vim.g.mkdp_filetypes = { "markdown" } end
  }, {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function() require('config/treesitter') end
  }, {
    'petertriho/nvim-scrollbar',
    config = function() require('scrollbar').setup() end
  }, {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('config/neogit') end
  }, {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('indent_blankline').setup() end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('config/gitsigns') end
  },

  { 'echasnovski/mini.nvim', config = function() require('config/mini') end },

  {
    'rcarriga/nvim-notify',
    config = function() require('config/nvim-notify') end
  }, {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }, --
  { 'elihunter173/dirbuf.nvim' }

}

require("lazy").setup(plugins, opts)
