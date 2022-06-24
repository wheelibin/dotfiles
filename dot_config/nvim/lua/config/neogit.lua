require('neogit').setup()

local legendary = require('legendary')
local helpers = require('legendary.helpers')
local filters = require('legendary.filters')

legendary.bind_keymaps({
  { '<F2>', helpers.lazy(legendary.find, nil, helpers.lazy(filters.current_mode)), description = 'Show Legendary' },
  { '<leader>g', helpers.lazy_required_fn('neogit', 'open', { kind = "vsplit" }), description = "Neogit Toggle" }
})
