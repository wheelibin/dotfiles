return {
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>s", "<cmd>lua require('spectre').toggle()<CR>", mode = { 'n' } },
    },
    opts = {
      is_block_ui_break = true
    }
  }
}
