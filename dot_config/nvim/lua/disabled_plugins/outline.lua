return {
  -- {
  --   "hedyhli/outline.nvim",
  --   lazy = true,
  --   cmd = { "Outline", "OutlineOpen" },
  --   keys = { -- Example mapping to toggle outline
  --     { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  --   },
  --   opts = {
  --     -- Your setup opts here
  --     -- outline_window = {
  --     --   auto_jump = true
  --     -- }
  --   },
  -- },
  -- { "artemave/workspace-diagnostics.nvim" }
  {
    'stevearc/aerial.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      disable_max_lines = 0,
      layout = {
        resize_to_content = false,
      }
    },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
}
