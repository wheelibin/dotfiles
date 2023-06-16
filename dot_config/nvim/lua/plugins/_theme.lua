return {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'warmer'
    }
    require('onedark').load()
  end,
}

-- return {
--   "sainnhe/gruvbox-material",
--   config = function()
--     vim.opt.termguicolors = true
--     vim.g.gruvbox_material_background = 'hard'
--     vim.g.gruvbox_material_better_performance = 1
--
--     vim.cmd("colorscheme gruvbox-material")
--   end
-- }

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   config = function()
--     vim.opt.termguicolors = true
--     vim.cmd("colorscheme catppuccin-mocha")
--   end
-- }

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
