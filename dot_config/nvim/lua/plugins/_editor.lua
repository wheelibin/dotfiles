local map = require('../utils').map

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    branch = "v2.x",
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
              added     = "",  -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "",  -- or "", but this is redundant info if you use git_status_colors on the name
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
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        buffers = {
          follow_current_file = true
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    'Bekaboo/dropbar.nvim',
    lazy = true,
    event = "BufEnter"
  },

  {
    "folke/flash.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
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
    version = '*',
    config = function()
      -- code commenting
      require('mini.comment').setup()

      -- highlight word under cursor
      require('mini.cursorword').setup({ delay = 400 })

      -- remove buffers retaining window layout
      require('mini.bufremove').setup()
      map("n", "<M-x>", "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })
    end
  },

  {
    'mrjones2014/smart-splits.nvim',
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
    version = "*",
    keys = {
      {
        "<leader>lg",
        mode = "n",
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" }):toggle()
        end
      }
    },
    config = function()
      require("toggleterm").setup {}
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      {
        "<leader>fp",
        mode = "n",
        function() require('telescope.builtin').find_files({ path_display = { 'truncate' } }) end,
        desc = "Find files"
      },
      {
        "<leader>fa",
        mode = "n",
        function() require('telescope.builtin').live_grep() end,
        desc = "Find text (grep)"
      },
      {
        "<leader><space>",
        mode = "n",
        function() require('telescope.builtin').buffers({ path_display = { 'truncate' } }) end,
        desc = "Find buffers"
      },
      {
        "<leader>fr",
        mode = "n",
        function() require('telescope.builtin').lsp_references({ path_display = { 'tail' } }) end,
        desc = "Find references (LSP)"
      },
      {
        "<leader>fe",
        mode = "n",
        function() require('telescope.builtin').diagnostics() end,
        desc = "Find errors (diagnostics) (LSP)"
      },
      {
        "<leader>fs",
        mode = "n",
        function() require('telescope.builtin').lsp_workspace_symbols() end,
        desc = "Find symbols (LSP)"
      },
      {
        "<leader>ds",
        mode = "n",
        function() require('telescope.builtin').lsp_document_symbols() end,
        desc = "Find document symbols (LSP)"
      },
      {
        "<leader>fi",
        mode = "n",
        function() require('telescope.builtin').lsp_implementations() end,
        desc = "Find implementations (LSP)"
      },
      {
        "<leader>fd",
        mode = "n",
        function() require('telescope.builtin').lsp_definitions() end,
        desc = "Find definitions (LSP)"
      },
      {
        "<leader>fh",
        mode = "n",
        function() require('telescope.builtin').git_bcommits() end,
        desc = "File history (git)"
      },
      {
        "<leader>fw",
        mode = "n",
        function() require('telescope.builtin').grep_string({ word_match = '-w', path_display = { 'truncate' } }) end,
        desc = "Find word under cursor"
      },
      {
        "<leader>tr",
        mode = "n",
        function() require('telescope.builtin').resume() end,
        desc = "Telescope resume"
      },
      {
        "<leader>/",
        mode = "n",
        function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }) end,
        desc = "Fuzzy find in current buffer"
      },

    },
    config = function()
      local telescope = require('telescope')
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function delete_others(bufnr)
        local current_picker = action_state.get_current_picker(bufnr)

        local selected = current_picker:get_selection_row()
        -- select all buffers
        actions.select_all(bufnr)
        -- deselect the current row
        current_picker:toggle_selection(selected)
        -- delete selected buffers
        actions.delete_buffer(bufnr)
      end

      telescope.setup {
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {  }
          }
        },
        defaults = {
          mappings = {
            i = {
              -- just close immediately on ESC rather than going to normal mode in the input
              ["<esc>"] = actions.close
            },
          },
          layout_config = {
            -- vertical = { width = 0.5 }
            -- other layout configuration here
          },
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                -- close the selected buffer directly from the picker
                ["<M-x>"] = "delete_buffer",
                -- close all buffers except the currently highlighted row
                ["<M-X>"] = delete_others,
              }
            }
          },
          find_files = {
            hidden = true
          },
          live_grep = {
            mappings = {
              i = {
                ["<M-r>"] = function(bufnr)
                  local find_string = action_state.get_current_line()
                  vim.ui.input({ prompt = "Replace string " .. find_string }, function(replace_string)
                    actions.send_selected_to_qflist(bufnr)
                    actions.open_qflist(bufnr)
                    vim.cmd('cdo s%' .. find_string .. '%' .. replace_string .. '%gc')
                  end)
                end
              }
            }
          }
        }
      }

      pcall(function()
        telescope.load_extension('frecency')
        telescope.load_extension('fzf')
        telescope.load_extension("ui-select")
      end)
    end
  }
}
