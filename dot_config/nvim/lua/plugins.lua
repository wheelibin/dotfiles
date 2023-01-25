-- bootstrap 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

 -- key mapping legend and discovery
  {
    'mrjones2014/legendary.nvim',
    dependencies = { { 'stevearc/dressing.nvim' } },
    config = function()
      require('legendary').setup()
    end
  },

    {
     'Mofiqul/dracula.nvim',
     config = function()
       vim.cmd('colorscheme dracula')
     end

   },

   -- file tree
    {
     'kyazdani42/nvim-tree.lua',
     dependencies = 'kyazdani42/nvim-web-devicons',
     config = function()
       require('config/nvim-tree')
     end
   },

--   -- highlight cursor movement
--   use 'DanilaMihailov/beacon.nvim'
--
   -- status bar
    {
     'nvim-lualine/lualine.nvim',
     dependencies = {
       { 'kyazdani42/nvim-web-devicons', lazy = true },
       { 'f-person/git-blame.nvim' },
       { 'arkav/lualine-lsp-progress' }
     },
     config = function()
       require('config/lualine')
     end
   },
   -- find files (fuzzy search/grep)
    {
     'nvim-telescope/telescope.nvim',
     dependencies = {
       { 'nvim-lua/plenary.nvim' },
       { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
       { 'nvim-telescope/telescope-frecency.nvim' },
       { 'kkharji/sqlite.lua' }
     },
     config = function()
       require('config/telescope')
     end
   },

   -- some language configs for the built-in language server
    {
     'neovim/nvim-lspconfig',
     dependencies = {
       'williamboman/mason.nvim',
       'williamboman/mason-lspconfig.nvim',
--       'lvimuser/lsp-inlayhints.nvim',
       'jose-elias-alvarez/typescript.nvim',
     },
     config = function()
       require('config/lspconfig')
     end
   },

--   -- Autocompletion plugin
   {
     'ms-jpq/coq_nvim',
     branch = 'coq',
     dependencies = {
       {'ms-jpq/coq.artifacts', branch =  'artifacts'}
     },
     config = function()
       vim.g.coq_settings = { auto_start= true }
     end
   },
--   use {
--     'hrsh7th/nvim-cmp',
--     requires = {
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-path',
--       'hrsh7th/cmp-cmdline',
--       'hrsh7th/cmp-vsnip',
--       'hrsh7th/vim-vsnip',
--       'hrsh7th/cmp-nvim-lsp-document-symbol',
--       'ray-x/lsp_signature.nvim',
--       'rafamadriz/friendly-snippets'
--     },
--     config = function()
--       require('config/nvim-cmp')
--     end
--   }
--   -- linting and more
--   use {
--     'jose-elias-alvarez/null-ls.nvim',
--     requires = { { 'nvim-lua/plenary.nvim' } },
--     config = function()
--       require('config/null-ls')
--     end
--   }
--   use {
--     "folke/trouble.nvim",
--     requires = "kyazdani42/nvim-web-devicons",
--     config = function()
--       require("trouble").setup {
--         -- your configuration comes here
--         -- or leave it empty to use the default settings
--         -- refer to the configuration section below
--       }
--     end
--   }
--
--   -- better syntax highlighting
    {
     'nvim-treesitter/nvim-treesitter',
     build = ':TSUpdate',
     config = function()
       require('config/treesitter')
     end
   },
--
--   -- use {
--   --   'neoclide/coc.nvim',
--   --   branch = 'release',
--   --   config = function()
--   --     require('config/coc')
--   --   end
--   -- }
--
--   -- fancy scrollbar with errors/warning markers
    {
     'petertriho/nvim-scrollbar',
     config = function()
       require('scrollbar').setup()
     end
   },
--
    {
     'TimUntersberger/neogit',
     dependencies = { 'nvim-lua/plenary.nvim' },
     config = function()
       require('config/neogit')
     end
   },
--
    {
     'lukas-reineke/indent-blankline.nvim',
     config = function()
       require('indent_blankline').setup()
     end
   },
--
    {
     'lewis6991/gitsigns.nvim',
     config = function()
       require('config/gitsigns')
     end
   },
--
   -- swiss army knife, see config to see which modules are enabled
    {
     'echasnovski/mini.nvim',
     config = function()
       require('config/mini')
     end
   },
--
    {
     'rcarriga/nvim-notify',
     config = function()
       require('config/nvim-notify')
     end
   },
--
--   use {
--     'windwp/nvim-autopairs',
--     config = function()
--       require('nvim-autopairs').setup {}
--     end
--   }
--
--   use {
--     'ethanholz/nvim-lastplace'
--   }
--
--   use {
--     'levouh/tint.nvim',
--     config = function()
--       require('tint').setup()
--     end
--   }
--
--   use {
--     'gennaro-tedesco/nvim-peekup'
--   }
--
--   use({
--     'mvllow/modes.nvim',
--     tag = 'v0.2.0',
--     config = function()
--       require('modes').setup()
--     end
--   })
--
--   use {
--     'ggandor/leap.nvim',
--     config = function()
--       require('config/leap')
--     end
--   }
--
    {
     'elihunter173/dirbuf.nvim'
   }



}

require("lazy").setup(plugins, opts)


--
-- --auto install the package manager on first use
-- local packer_installed = false
-- local fn = vim.fn
-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_installed = fn.system({
--     'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
--   })
-- end
--
-- return require('packer').startup(function(use)
--   -- packer itself
--   use 'wbthomason/packer.nvim'
--
--   -- Speed up loading Lua modules in Neovim to improve startup time
--   use {
--     'lewis6991/impatient.nvim'
--   }
--
--   -- key mapping legend and discovery
--   use {
--     'mrjones2014/legendary.nvim',
--     requires = { { 'stevearc/dressing.nvim' } },
--     config = function()
--       require('legendary').setup()
--     end
--   }
--
--   -- Using Packer:
--   use {
--     'Mofiqul/dracula.nvim',
--     config = function()
--       vim.cmd('colorscheme dracula')
--     end
--
--   }
--
--   -- file tree
--   use {
--     'kyazdani42/nvim-tree.lua',
--     requires = 'kyazdani42/nvim-web-devicons',
--     config = function()
--       require('config/nvim-tree')
--     end
--   }
--
--   -- highlight cursor movement
--   use 'DanilaMihailov/beacon.nvim'
--
--   -- status bar
--   use {
--     'nvim-lualine/lualine.nvim',
--     requires = {
--       { 'kyazdani42/nvim-web-devicons', opt = true },
--       { 'f-person/git-blame.nvim' },
--       { 'arkav/lualine-lsp-progress' }
--     },
--     config = function()
--       require('config/lualine')
--     end
--   }
--
--   -- find files (fuzzy search/grep)
--   use {
--     'nvim-telescope/telescope.nvim',
--     requires = {
--       { 'nvim-lua/plenary.nvim' },
--       { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
--       { 'nvim-telescope/telescope-frecency.nvim' },
--       { 'fannheyward/telescope-coc.nvim' },
--       { 'kkharji/sqlite.lua' }
--     },
--     config = function()
--       require('config/telescope')
--     end
--   }
--
--   -- some language configs for the built-in language server
--   use {
--     'neovim/nvim-lspconfig',
--     requires = {
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
--       'lvimuser/lsp-inlayhints.nvim',
--       'jose-elias-alvarez/typescript.nvim',
--     },
--     config = function()
--       require('config/lspconfig')
--     end
--   }
--
--   -- Autocompletion plugin
--   use {
--     'hrsh7th/nvim-cmp',
--     requires = {
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-path',
--       'hrsh7th/cmp-cmdline',
--       'hrsh7th/cmp-vsnip',
--       'hrsh7th/vim-vsnip',
--       'hrsh7th/cmp-nvim-lsp-document-symbol',
--       'ray-x/lsp_signature.nvim',
--       'rafamadriz/friendly-snippets'
--     },
--     config = function()
--       require('config/nvim-cmp')
--     end
--   }
--   -- linting and more
--   use {
--     'jose-elias-alvarez/null-ls.nvim',
--     requires = { { 'nvim-lua/plenary.nvim' } },
--     config = function()
--       require('config/null-ls')
--     end
--   }
--   use {
--     "folke/trouble.nvim",
--     requires = "kyazdani42/nvim-web-devicons",
--     config = function()
--       require("trouble").setup {
--         -- your configuration comes here
--         -- or leave it empty to use the default settings
--         -- refer to the configuration section below
--       }
--     end
--   }
--
--   -- better syntax highlighting
--   use {
--     'nvim-treesitter/nvim-treesitter',
--     run = ':TSUpdate',
--     config = function()
--       require('config/treesitter')
--     end
--   }
--
--   -- use {
--   --   'neoclide/coc.nvim',
--   --   branch = 'release',
--   --   config = function()
--   --     require('config/coc')
--   --   end
--   -- }
--
--   -- fancy scrollbar with errors/warning markers
--   use {
--     'petertriho/nvim-scrollbar',
--     config = function()
--       require('scrollbar').setup()
--     end
--   }
--
--   use {
--     'TimUntersberger/neogit',
--     requires = { 'nvim-lua/plenary.nvim' },
--     config = function()
--       require('config/neogit')
--     end
--   }
--
--   use {
--     'lukas-reineke/indent-blankline.nvim',
--     config = function()
--       require('indent_blankline').setup()
--     end
--   }
--
--   use {
--     'lewis6991/gitsigns.nvim',
--     config = function()
--       require('config/gitsigns')
--     end
--   }
--
--   -- swiss army knife, see config to see which modules are enabled
--   use {
--     'echasnovski/mini.nvim',
--     config = function()
--       require('config/mini')
--     end
--   }
--
--   use {
--     'rcarriga/nvim-notify',
--     config = function()
--       require('config/nvim-notify')
--     end
--   }
--
--   use {
--     'windwp/nvim-autopairs',
--     config = function()
--       require('nvim-autopairs').setup {}
--     end
--   }
--
--   use {
--     'ethanholz/nvim-lastplace'
--   }
--
--   use {
--     'levouh/tint.nvim',
--     config = function()
--       require('tint').setup()
--     end
--   }
--
--   use {
--     'gennaro-tedesco/nvim-peekup'
--   }
--
--   use({
--     'mvllow/modes.nvim',
--     tag = 'v0.2.0',
--     config = function()
--       require('modes').setup()
--     end
--   })
--
--   use {
--     'ggandor/leap.nvim',
--     config = function()
--       require('config/leap')
--     end
--   }
--
--   use {
--     'elihunter173/dirbuf.nvim'
--   }
--
--
--   -- Automatically set up your configuration after cloning packer.nvim
--   -- Put this at the end after all plugins
--   if packer_installed then
--     require('packer').sync()
--   end
-- end)
