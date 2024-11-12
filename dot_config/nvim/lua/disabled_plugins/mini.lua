return {
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
      vim.keymap.set("n", "<M-x>", "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })

      -- smart aligning
      require('mini.align').setup()

      -- sensible default options
      -- require('mini.basics').setup()
    end
  }
}
