return {
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    keys = {
      { "<leader>s", "<cmd>lua require('spectre').toggle()<CR>", mode = { 'n' } },
    },
    opts = {
      -- is_block_ui_break = true
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "",
            "-E",
          },
        },
      },
    }
  }
}
