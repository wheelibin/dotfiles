local map = require('../utils').map

return {
  "towolf/vim-helm",
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
    keys = {
      {
        "<leader>fd",
        mode = "n",
        function() require('fzf-lua').files({ path_shorten = 6 }) end,
        desc = "Find files"
      },
      {
        "<leader>fa",
        mode = "n",
        function() require('fzf-lua').live_grep_native({ path_shorten = 6 }) end,
        desc = "Find text (grep)"
      },
      {
        "<leader><space>",
        mode = "n",
        function() require('fzf-lua').buffers({ path_shorten = 6 }) end,
        desc = "Find buffers"
      },
      {
        "<leader>fr",
        mode = "n",
        function() require('fzf-lua').lsp_references() end,
        desc = "Find references (LSP)"
      },
      {
        "<leader>fe",
        mode = "n",
        function() require('fzf-lua').diagnostics_workspace() end,
        desc = "Find errors (diagnostics) (LSP)"
      },
      {
        "<leader>fs",
        mode = "n",
        function() require('fzf-lua').lsp_live_workspace_symbols() end,
        desc = "Find symbols (LSP)"
      },
      {
        "<leader>ds",
        mode = "n",
        function() require('fzf-lua').lsp_document_symbols() end,
        desc = "Find document symbols (LSP)"
      },
      {
        "gi",
        mode = "n",
        function() require('fzf-lua').lsp_implementations() end,
        desc = "Find implementations (LSP)"
      },
      -- {
      --   "gd",
      --   mode = "n",
      --   function() require('fzf-lua').lsp_definitions() end,
      --   desc = "Find definitions (LSP)"
      -- },
      {
        "<leader>fh",
        mode = "n",
        function() require('fzf-lua').git_bcommits() end,
        desc = "File history (git)"
      },
      {
        "<leader>fc",
        mode = "n",
        function() require('fzf-lua').git_commits() end,
        desc = "Find Commits (git)"
      },
      {
        "<leader>fw",
        mode = "n",
        function() require('fzf-lua').grep_cword() end,
        desc = "Find word under cursor"
      },
      {
        "<leader>fw",
        mode = "v",
        function() require('fzf-lua').grep_visual() end,
        desc = "Find selection"
      },
      {
        "<leader>re",
        mode = "n",
        function() require('fzf-lua').registers() end,
        desc = "View registers"
      },
      {
        "<leader>tr",
        mode = "n",
        function() require('fzf-lua').resume() end,
        desc = "Telescope resume"
      },
      {
        "<leader>fm",
        mode = "n",
        function() require('fzf-lua').keymaps() end,
        desc = "Find keymaps"
      },
      {
        "<leader>ft",
        mode = "n",
        function() require('fzf-lua').colorschemes() end,
        desc = "Find themes (colorschemes)"
      },
      {
        "<leader>ca",
        mode = "n",
        function() require('fzf-lua').lsp_code_actions() end,
        desc = "Code Actions (LSP)"
      },
      {
        "<leader>d",
        mode = "n",
        function() require('fzf-lua').dap_commands() end,
        desc = "Debug (DAP)"
      },
      {
        "<leader>/",
        mode = "n",
        function() require('fzf-lua').lgrep_curbuf() end,
        desc = "Fuzzy find in current buffer"
      },

      -- {
      --   "<leader>/",
      --   mode = "n",
      --   function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }) end,
      --   desc = "Fuzzy find in current buffer"
      -- },
      -- {
      --   "<leader>ch",
      --   mode = "n",
      --   require('telescope.builtin').command_history,
      --   desc = "Command History"
      -- },
      --
    }
  },
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    config = function()
      require 'window-picker'.setup({
        -- type of hints you want to get
        -- following types are supported
        -- 'statusline-winbar' | 'floating-big-letter'
        -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
        -- 'floating-big-letter' draw big letter on a floating window
        -- used
        hint = 'floating-big-letter',

        -- when you go to window selection mode, status bar will show one of
        -- following letters on them so you can use that letter to select the window
        selection_chars = 'tnseriao',

        -- whether to show 'Pick window:' prompt
        show_prompt = false,

        -- prompt message to show to get the user input
        -- prompt_message = 'Pick window: ',

      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    keys = {
      {
        "<leader>n",
        "<cmd>Neotree source=filesystem reveal=true position=left toggle=true<cr>",
        desc = 'Nvim-Tree Toggle'
      }
    },
    config = function()
      require("neo-tree").setup({
        -- source_selector = {
        --   winbar = true,
        -- },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖", -- this can only be used in the git_status source
              renamed   = "", -- this can only be used in the git_status source
              -- Status type
              untracked = "?",
              ignored   = "",
              unstaged  = "u",
              staged    = "s",
              conflict  = "",
            }
          },
        },
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        buffers = {
          follow_current_file = { enabled = true }
        },
        window = {
          mappings = {
            -- remap (m)ove to (mv)ove
            ["m"] = "none",
            ["mv"] = "move",
            -- remove "e"
            ["e"] = "none"
          }
        }
      })
    end
  },

  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    "NStefan002/visual-surround.nvim",
    config = function()
      require("visual-surround").setup({
        -- your config
      })
    end,
    -- or if you don't want to change defaults
    -- config = true
  },

  -- {
  --   'Bekaboo/dropbar.nvim',
  --   -- optional, but required for fuzzy finder support
  --   dependencies = {
  --     -- 'nvim-telescope/telescope-fzf-native.nvim'
  --   },
  --   config = function()
  --     map("n", "<leader>d", require('dropbar.api').pick, { desc = 'Dropbar pick mode' })
  --   end
  -- },

  {
    "folke/flash.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      labels = "tnseriaoplfuwydhc",
      modes = {
        search = {
          enabled = false
        }
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      {
        "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search"
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        search = {
          pattern = [[\b(KEYWORDS)(:|\s)]]
        },
        highlight = {
          pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        },
      }
    end
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      -- code commenting
      require('mini.comment').setup()

      -- highlight word under cursor
      require('mini.cursorword').setup({ delay = 400 })

      require('mini.animate').setup({
        -- scroll = { timing = function() return 2 end },
        scroll = { enable = false },
        resize = { enable = false }
      })

      -- remove buffers retaining window layout
      require('mini.bufremove').setup()
      map("n", "<M-x>", "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })
    end
  },

  {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    lazy = true,
    keys = {
      { "<M-m>", mode = "n", function() require('smart-splits').move_cursor_left() end,  desc = "Move to window left" },
      { "<M-n>", mode = "n", function() require('smart-splits').move_cursor_down() end,  desc = "Move to window down" },
      { "<M-e>", mode = "n", function() require('smart-splits').move_cursor_up() end,    desc = "Move to window up" },
      { "<M-i>", mode = "n", function() require('smart-splits').move_cursor_right() end, desc = "Move to window right" },
    }
  },

  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    event = "BufEnter *.md",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end
  },

  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    keys = {
      {
        "<leader>lg",
        mode = "n",
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" }):toggle()
        end
      },
      {
        "<leader>el",
        mode = "n",
        function()
          local trim_spaces = true
          require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
        end
      }
    },
    config = function()
      require("toggleterm").setup {}
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require('treesitter-context').setup({
            separator = "┈",
          })
          map('n', '<leader>c', require("treesitter-context").go_to_context)
          -- vim.cmd [[ hi! def link TreesitterContext LspInlayHint ]]
          -- vim.cmd [[ hi TreesitterContext gui=italic ]]
        end
      },
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_text_obj_enabled = 0
        end
      },
    },
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'html',
          'http',
          'go',
          'graphql',
          'javascript',
          'json',
          'lua',
          'python',
          'typescript',
          'tsx',
          'vim',
          'regex',
          'markdown',
          'markdown_inline',
          'yaml'
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false
        },

        indent = { enable = true },
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     init_selection = '<c-space>',
        --     node_incremental = '<c-space>',
        --     scope_incremental = '<c-s>',
        --     node_decremental = '<M-space>',
        --   },
        -- },

      }
    end
  }
}
