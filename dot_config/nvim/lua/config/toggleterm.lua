require('toggleterm').setup({
  open_mapping = [[`]],
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  direction = 'vertical',
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end
})

local legendary = require('legendary')

function _G.set_terminal_keymaps()
  legendary.keymap({ '<esc>', [[<C-\><C-n>]], description = 'Toggle Term', buffer = 0, mode = 't' })
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
