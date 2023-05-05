local map = require('./utils').map

vim.g.mapleader = ' '

vim.g.coq_settings = { auto_start = 'shut-up' }

local opt = vim.opt

-- disable word wrap
opt.wrap = false

-- Enable break indent
opt.breakindent = true

-- persistent undo history
opt.undofile = true

-- line numbers
opt.number = true
-- opt.relativenumber = true

-- search flags
opt.ignorecase = true
opt.smartcase = true

-- whitespace
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Decrease update time
opt.updatetime = 250
opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- needed for colorizer
opt.termguicolors = true

-- enable the mouse in (a)ll modes
opt.mouse = 'a'

-- scroll offset
opt.scrolloff = 4

opt.cursorline = true

opt.swapfile = false

-- hide the tildes showing end of buffer
opt.fcs = "eob: "

map('n', ';', ':', { noremap = true })
map('n', ':', ';', { noremap = true })

-- remap hjkl to colemak homerow equivalents
map('n', 'm', 'h', { noremap = true })
map('n', 'n', 'j', { noremap = true })
map('n', 'e', 'k', { noremap = true })
map('n', 'i', 'l', { noremap = true })
map('v', 'm', 'h', { noremap = true })
map('v', 'n', 'j', { noremap = true })
map('v', 'e', 'k', { noremap = true })
map('v', 'i', 'l', { noremap = true })

-- now we need to remap the keys we took for hjkl
-- move insert at cursor to o
map('n', 'o', 'i', { noremap = true })
map('n', 'O', 'I', { noremap = true })
map('v', 'o', 'i', { noremap = true })
map('v', 'O', 'I', { noremap = true })

-- now we need to move o, so h seems good as it's "below" so is fairly logical
map('n', 'h', 'o', { noremap = true })
map('n', 'H', 'O', { noremap = true })
map('v', 'h', 'o', { noremap = true })
map('v', 'H', 'O', { noremap = true })
-- jump to next search
map('n', 'k', 'n', { noremap = true })
map('n', 'K', 'N', { noremap = true })
map('v', 'k', 'n', { noremap = true })
map('v', 'K', 'N', { noremap = true })
-- move to end of next word
map('n', 'l', 'e', { noremap = true })
map('v', 'l', 'e', { noremap = true })
