-- function melange_no_variants()
--   vim.g.melange_enable_font_variants = 0 -- disable font variants
--   require("lush")                        -- make sure Lush is installed
--   require("melange.build").build()       -- Compile to vimscript
-- end

return {
  'savq/melange-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- melange_no_variants()
    vim.opt.termguicolors = true
    vim.cmd('colorscheme melange')
  end
}
