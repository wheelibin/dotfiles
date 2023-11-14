vim.g.mapleader = ' '

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

-- sync clipboard between nvim and OS
opt.clipboard = 'unnamedplus'

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

-- show sign column
opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- needed for colorizer
opt.termguicolors = true

-- enable the mouse in (a)ll modes
opt.mouse = 'a'

-- scroll offset
opt.scrolloff = 4

-- full line at cursor position
opt.cursorline = true

opt.swapfile = false

-- cursor not allowed in whitespace
opt.virtualedit = 'none'

-- hide the tildes showing end of buffer
opt.fcs = "eob: "


-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldmethod = "indent"
