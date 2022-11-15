require('leap').add_default_mappings()

local legendary = require('legendary')
legendary.keymap({ 'f', '<Plug>(leap-forward-to)', description = 'Leap (forward)' })
legendary.keymap({ 'F', '<Plug>(leap-backward-to)', description = 'Leap (backward)' })
