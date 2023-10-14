local map = require('../utils').map

-- buffer switching
map("n", '<bs>', '<C-^>', { desc = 'Edit alternative file' })

-- windows
map("n", '<M-q>', ':wincmd q<CR>', { desc = 'Close current window' })

map("n", '<M-S-m>', ':wincmd v<CR>:wincmd h<CR>', { desc = 'New window left' })
map("n", '<M-S-n>', ':wincmd s<CR>', { desc = 'New window below' })
map("n", '<M-S-e>', ':wincmd s<CR>:wincmd k<CR>', { desc = 'New window above' })
map("n", '<M-S-i>', ':wincmd v<CR>', { desc = 'New window right' })

-- move lines
map("n", '<C-up>', ':m .-2<CR>==', { desc = 'Move line up' })
map("i", '<C-up>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up' })
map("v", '<C-up>', ':m \'<-2<CR>gv=gv', { desc = 'Move line up' })
map("n", '<C-down>', ':m .+1<CR>==', { desc = 'Move line up' })
map("i", '<C-down>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line up' })
map("v", '<C-down>', ':m \'>+1<CR>gv=gv', { desc = 'Move line up' })

map('n', ';', ':')
map('n', ':', ';')

-- Remap for dealing with word wrap
--map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
--map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

--- center in page nav
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- exit insert mode
map('i', 'hh', '<Esc>')

map('n', '<C-p>', '"0p')
map('n', '<C-P>', '"0P')

-- jump to next search (+centering)
map('', 'n', 'nzzzv', {})
map('', 'N', 'Nzzzv', {})

map('n', '<leader><bs>', ':noh<CR>', { desc = 'Clear search highlighting' })
map('', '<space>', '<nop>', { silent = true })

-- paste from reg 0 (pastes yanked content even after delete)
map('', '<leader>p', '=0p')

-- colemak specific mappings
--------------------------
-- remap hjkl to colemak homerow equivalents
map('', 'm', 'h', {})
map('', 'n', 'j', {})
map('', 'e', 'k', {})
map('', 'i', 'l', {})

-- now we need to remap the keys we took for hjkl
-- move insert at cursor to o
map('', 'o', 'i', {})
map('', 'O', 'I', {})

-- now we need to move o, so h seems good as it's "below" so is fairly logical
map('', 'h', 'o', {})
map('', 'H', 'O', {})

-- jump to next search (+centering)
map('', 'k', 'n', {})
map('', 'K', 'N', {})

-- move to end of next word
map('', 'l', 'e', {})
--------------------------
