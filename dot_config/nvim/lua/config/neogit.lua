require('neogit').setup()

local legendary = require('legendary')
local legendary_toolbox = require('legendary.toolbox')
local filters = require('legendary.filters')

legendary.keymaps({
  { '<F2>', legendary_toolbox.lazy(legendary.find, nil, legendary_toolbox.lazy(filters.current_mode)),
    description = 'Show Legendary' },
  { '<leader>g', legendary_toolbox.lazy_required_fn('neogit', 'open', { kind = 'vsplit' }), description = 'Neogit Toggle' }
})
