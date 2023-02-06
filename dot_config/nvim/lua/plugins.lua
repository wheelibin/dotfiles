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
    config = function()
      require('legendary').setup()
    end
  },

  {
    'savq/melange-nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd('colorscheme melange')
    end
  },

  -- {
  --   'AlexvZyl/nordic.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require 'nordic'.load()
  --   end
  -- },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      require('config/neo-tree')
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'f-person/git-blame.nvim' }, { 'arkav/lualine-lsp-progress' }
    },
    config = function()
      require('config/lualine')
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      'nvim-telescope/telescope-frecency.nvim',
      'kkharji/sqlite.lua',
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require('config/telescope')
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'lvimuser/lsp-inlayhints.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'ray-x/lsp_signature.nvim'
    },
    config = function()
      require('config/lspconfig')
    end
  },

  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    dependencies = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } },
    config = function()
      require('config/coq')
    end
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config/null-ls')
    end
  },

  {
    'neoclide/coc.nvim', 
    branch = 'release'
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('config/treesitter')
    end
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  },

  {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config/neogit')
    end
  },

  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = function()
  --     require('indent_blankline').setup()
  --   end
  -- },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('config/gitsigns')
    end
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('config/mini')
    end
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('config/nvim-notify')
    end
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  },

  { 'elihunter173/dirbuf.nvim' }, {
    'phaazon/mind.nvim',
    branch = 'v2.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'mind'.setup()
    end
  },
  
  {
    'ggandor/leap.nvim',
    lazy=false,
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      -- see lspconfig for more
    end

  },

  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup({
        foldfunc = "builtin",
        setopt = true,
      })
    end
  }
}

require("lazy").setup(plugins)
