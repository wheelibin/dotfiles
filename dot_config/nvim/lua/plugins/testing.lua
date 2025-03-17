return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        dir = "~/dev/neotest-golang"
      }, -- Installation
      "nvim-neotest/neotest-jest"
    },
    keys = {
      { "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>",                   mode = { 'n' } },
      { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", mode = { 'n' } },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", mode = { 'n' } },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-golang"), -- Registration
          require('neotest-jest')({
            -- jestCommand = "npm test --",
            -- jestConfigFile = "custom.jest.config.ts",
            -- env = { CI = true },
            -- cwd = function(path)
            --   return vim.fn.getcwd()
            -- end,
          }),
        },
      })
    end,
  },
}
