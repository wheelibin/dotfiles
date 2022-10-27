require('leap').add_default_mappings()

local legendary = require('legendary')
legendary.bind_keymap({ 'f', '<Plug>(leap-forward-to)', description = 'Leap (forward)' })
legendary.bind_keymap({ 'F', '<Plug>(leap-backward-to)', description = 'Leap (backward)' })
