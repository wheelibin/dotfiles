return {
  'EdenEast/nightfox.nvim',

  dependencies = {
    -- just install others here
    { 'catppuccin/nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'savq/melange-nvim' }
  },
  config = function()
    vim.g.melange_enable_font_variants = 0
    vim.cmd('colorscheme melange')
  end

}

-- return {
--   -- Theme inspired by Atom
--   'navarasu/onedark.nvim',
--   priority = 1000,
--   config = function()
--     require('onedark').setup {
--       style = 'warmer'
--     }
--     require('onedark').load()
--   end,
-- }

-- return {
--   "sainnhe/gruvbox-material",
--   config = function()
--     vim.opt.termguicolors = true
--     -- vim.g.gruvbox_material_background = 'hard'
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
--     vim.cmd("colorscheme catppuccin-macchiato")
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



-- return {
--   'sainnhe/sonokai',
--   config = function()
--     vim.g.sonokai_style = 'atlantis'
--     vim.g.sonokai_better_performance = 1
--     vim.cmd('colorscheme sonokai')
--   end
--
-- }

-- return {
--   "shaunsingh/nord.nvim",
--   name = "nord",
--   config = function()
--     vim.opt.termguicolors = true
--     vim.cmd("colorscheme nord")
--   end
-- }
