-- prevent tree from moving to the right on first file open
vim.opt.splitright = true

require('nvim-tree').setup({
  reload_on_bufenter = true,
  view = {
    mappings = {
      custom_only = false,
      list = { { key = 'l', action = 'edit' }, { key = 'L', action = 'preview' }, { key = 'h', action = 'close_node' } }
    }
  },
  update_focused_file = {
    enable = true,
  },
  -- to play nicely with dirbuf
  hijack_directories = { enable = false }
})

local legendary = require('legendary')
legendary.keymap({ '<leader>n', [[:NvimTreeToggle<cr>]], description = 'Nvim-Tree Toggle' })
