return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    vim.opt.termguicolors = true
    vim.cmd("colorscheme catppuccin-mocha")
  end
}

-- return {
--   'savq/melange-nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- melange_no_variants()
--     vim.opt.termguicolors = true
--     vim.cmd('colorscheme melange')
--   end
-- }
