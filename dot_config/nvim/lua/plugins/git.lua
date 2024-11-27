return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = "BufEnter",
    config = function()
      require('gitsigns').setup({
        on_attach = function()
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set('n', '<M-C-h>', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Goto next change/hunk (GIT)" })

          vim.keymap.set('n', '<M-C-,>', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Goto previous change/hunk (GIT)" })

          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = "Reset change/hunk (GIT)" })
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = "Preview Hunk (GIT)" })
        end
      })
    end
  }
}
