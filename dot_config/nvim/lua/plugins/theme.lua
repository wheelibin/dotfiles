return {
  {
    'EdenEast/nightfox.nvim',
    name = 'theme: nightfox',
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme duskfox')
    end
  },
  {
    "rose-pine/neovim",
    name = "theme: rose-pine",
    config = function()
      require("rose-pine").setup({ variant = "moon" })
      vim.cmd('colorscheme rose-pine')
    end
  }
}
