return {
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
    opts = {
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
        diagnostics = {
          symbols = {
            hint = "⚑",
            info = "",
            warn = "▲",
            error = "✘",
          },
          highlights = {
            hint = "DiagnosticSignHint",
            info = "DiagnosticSignInfo",
            warn = "DiagnosticSignWarn",
            error = "DiagnosticSignError",
          },
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
          ["e"] = "none",
          -- open split on right
          ["s"] = "open_rightbelow_vs"
        }
      }
    }
  }
}
